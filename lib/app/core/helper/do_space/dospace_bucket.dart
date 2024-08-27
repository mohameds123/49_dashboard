import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:xml/xml.dart' as xml;
import '../../widget/custom_alert.dart';
import 'dospace_client.dart';
import 'dospace_results.dart';

enum Permissions {
  private,
  public,
}

class Bucket extends Client {
  Bucket({
    required super.region,
    required super.accessKey,
    required super.secretKey,
    super.endpointUrl,
    super.httpClient,
  }) : super(service: "s3") {
    // ...
  }

  void bucket(String bucket) {
    if (endpointUrl == "https://$region.digitaloceanspaces.com") {
    } else {
      throw Exception(
        "Endpoint URL not supported. Create Bucket client manually.",
      );
    }
  }

  /// List the Bucket's Contents.
  /// https://developers.digitalocean.com/documentation/spaces/#list-bucket-contents
  Stream<BucketContent> listContents({
    String? delimiter,
    String? prefix,
    int? maxKeys,
  }) async* {
    late bool isTruncated;
    String? marker;
    do {
      Uri uri = Uri.parse('$endpointUrl/');
      final Map<String, dynamic> params = <String, dynamic>{};
      if (delimiter != null) params['delimiter'] = delimiter;
      if (marker != null) {
        params['marker'] = marker;
        marker = null;
      }
      if (maxKeys != null) params['max-keys'] = "$maxKeys";
      if (prefix != null) params['prefix'] = prefix;
      uri = uri.replace(queryParameters: params);
      final xml.XmlDocument doc = await getUri(uri);
      for (final xml.XmlElement root in doc.findElements('ListBucketResult')) {
        for (final xml.XmlNode node in root.children) {
          if (node is xml.XmlElement) {
            final xml.XmlElement ele = node;
            switch ('${ele.name}') {
              case "NextMarker":
                marker = ele.text;
                break;
              case "IsTruncated":
                isTruncated =
                    ele.text.toLowerCase() != "false" && ele.text != "0";
                break;
              case "Contents":
                String? key;
                DateTime? lastModifiedUtc;
                String? eTag;
                int? size;
                for (final xml.XmlNode node in ele.children) {
                  if (node is xml.XmlElement) {
                    final xml.XmlElement ele = node;
                    switch ('${ele.name}') {
                      case "Key":
                        key = ele.text;
                        break;
                      case "LastModified":
                        lastModifiedUtc = DateTime.parse(ele.text);
                        break;
                      case "ETag":
                        eTag = ele.text;
                        break;
                      case "Size":
                        size = int.parse(ele.text);
                        break;
                    }
                  }
                }
                yield BucketContent(
                  key: key,
                  lastModifiedUtc: lastModifiedUtc,
                  eTag: eTag,
                  size: size,
                );
                break;
            }
          }
        }
      }
    } while (isTruncated);
  }

  Future<String?> uploadFile(
    String filePath,
    String contentType,
    String extensionName, {
    Map<String, String>? meta,
    String? key,
    Permissions permissions = Permissions.public,
  }) async {
    try {
      final path = key ??
          '${const Uuid().v4()}${const Uuid().v4()}${const Uuid().v4()}.$extensionName';

      final file = File(filePath);
      final int contentLength = await file.length();
      final Digest contentSha256 = await sha256.bind(file.openRead()).first;
      final String uriStr = '$endpointUrl/$path';
      final http.StreamedRequest request =
          http.StreamedRequest('PUT', Uri.parse(uriStr));
      final Stream<List<int>> stream = file.openRead();
      stream.listen(
        request.sink.add,
        onError: request.sink.addError,
        onDone: request.sink.close,
      );
      if (meta != null) {
        for (final MapEntry<String, String> me in meta.entries) {
          request.headers["x-amz-meta-${me.key}"] = me.value;
        }
      }
      if (permissions == Permissions.public) {
        request.headers['x-amz-acl'] = 'public-read';
      }
      request.headers['Content-Length'] = contentLength.toString();
      request.headers['Content-Type'] = contentType;
      signRequest(request, contentSha256: contentSha256);
      final http.StreamedResponse response = await httpClient.send(request);
      final String body = await utf8.decodeStream(response.stream);
      if (response.statusCode != 200) {
        throw ClientException(
          response.statusCode,
          response.reasonPhrase,
          response.headers,
          body,
        );
      }
      return path;
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
    return null;
  }

  /// Uploads data from memory. Returns Etag.
  Future<String?> uploadData(
    String key,
    Uint8List data,
    String contentType,
    Permissions permissions, {
    Map<String, String>? meta,
    Digest? contentSha256,
  }) async {
    final int contentLength = data.length;
    final Digest contentSha256_ = contentSha256 ?? sha256.convert(data);
    final String uriStr = '$endpointUrl/$key';
    final http.Request request = http.Request('PUT', Uri.parse(uriStr));
    request.bodyBytes = data;
    if (meta != null) {
      for (final MapEntry<String, String> me in meta.entries) {
        request.headers["x-amz-meta-${me.key}"] = me.value;
      }
    }
    if (permissions == Permissions.public) {
      request.headers['x-amz-acl'] = 'public-read';
    }
    request.headers['Content-Length'] = contentLength.toString();
    request.headers['Content-Type'] = contentType;
    signRequest(request, contentSha256: contentSha256_);
    final http.StreamedResponse response = await httpClient.send(request);
    final String body =
        await utf8.decodeStream(response.stream); // Should be empty when OK
    if (response.statusCode != 200) {
      throw ClientException(
        response.statusCode,
        response.reasonPhrase,
        response.headers,
        body,
      );
    }
    final String? etag = response.headers['etag'];
    return etag;
  }

  String? preSignUpload(
    String key, {
    int? contentLength,
    String? contentType,
    Digest? contentSha256,
    Permissions permissions = Permissions.private,
    int expires = 900,
    Map<String, String>? meta,
  }) {
    final String uriStr = '$endpointUrl/$key';
    final Uri uriBase = Uri.parse(uriStr);
    final Map<String, String> queryParameters = <String, String>{};
    if (meta != null) {
      for (final MapEntry<String, String> me in meta.entries) {
        queryParameters["x-amz-meta-${me.key}"] = me.value;
      }
    }
    /*if (permissions == Permissions.public) {
      queryParameters['x-amz-acl'] = 'public-read';
    }*/ // This isn't working ?!
    final http.Request request =
        http.Request('PUT', uriBase.replace(queryParameters: queryParameters));
    if (contentLength != null) {
      request.headers['Content-Length'] = contentLength.toString();
    }
    if (contentType != null) request.headers['Content-Type'] = contentType;
    if (permissions == Permissions.public) {
      request.headers['x-amz-acl'] = 'public-read';
    }
    return signRequest(
      request,
      contentSha256: contentSha256,
      expires: expires,
      preSignedUrl: true,
    );
  }
}
