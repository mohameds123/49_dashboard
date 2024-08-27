import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import 'dospace_bucket.dart';
import 'dospace_client.dart';

class Spaces extends Client {
  Spaces({
    required super.region,
    required super.accessKey,
    required super.secretKey,
    super.endpointUrl,
    super.httpClient,
  }) : super(
          service: "s3",
        ) {
    // ...
  }

  Bucket bucket(String? bucket) {
    if (endpointUrl == "https://$region.digitaloceanspaces.com") {
      return Bucket(
        region: region,
        accessKey: accessKey,
        secretKey: secretKey,
        endpointUrl: "https://$bucket.$region.digitaloceanspaces.com",
        httpClient: httpClient,
      );
    } else {
      throw Exception(
        "Endpoint URL not supported. Create Bucket client manually.",
      );
    }
  }

  Future<List<String>> listAllBuckets() async {
    final xml.XmlDocument doc = await getUri(Uri.parse('$endpointUrl/'));
    final List<String> res = [];
    for (final xml.XmlElement root
        in doc.findElements('ListAllMyBucketsResult')) {
      for (final xml.XmlElement buckets in root.findElements('Buckets')) {
        for (final xml.XmlElement bucket in buckets.findElements('Bucket')) {
          for (final xml.XmlElement name in bucket.findElements('Name')) {
            res.add(name.text);
          }
        }
      }
    }
    return res;
  }

  String? preSignListAllBuckets() {
    final http.Request request =
        http.Request('GET', Uri.parse('$endpointUrl/'));
    return signRequest(request, preSignedUrl: true);
  }
}
