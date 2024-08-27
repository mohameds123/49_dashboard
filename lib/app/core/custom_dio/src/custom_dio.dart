import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_x;
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'custom_dio_exception.dart';
import 'custom_dio_options.dart';

CustomDioOptions? options;

class CustomDio {
  static final httpClient = HttpClient();
  late Dio _dio;

  CustomDio({bool enableLog = false}) {
    if (options == null) {
      throw "Make sure to call CustomDio.setInitData() before you submit request";
    }
    _dio = Dio();
    _dio.options.baseUrl = options!.baseUrl;
    _dio.options.validateStatus = (_) => true;
    _dio.options.followRedirects = options!.followRedirects;
    _dio.options.headers = options!.headers;
    _dio.options.sendTimeout = options!.sendTimeout;
    _dio.options.receiveTimeout = options!.receiveTimeout;
    _dio.options.connectTimeout = options!.connectTimeout;
    _dio.interceptors.addAll(options!.interceptorsList);
    _dio.options.headers['Language'] = get_x.Get.locale?.languageCode ?? 'en';
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          maxWidth: 100,
        ),
      );
    }
  }

  static Future<dynamic> httpGet(String url) async {
    try {
      final req = await http.get(Uri.parse(options!.baseUrl + url));
      _throwIfHttpNoSuccess(req);
      final d = jsonDecode(req.body);
      return d;
    } catch (err) {
      throw CustomDioException(err.toString(), 500);
    }
  }

  /// init the package
  static void setInitData(CustomDioOptions dioOptions) {
    options = dioOptions;
  }

  static void changeOptionsHeaders({String? token}) {
    if (token != null) {
      options!.headers!['authorization'] = "Bearer $token";
    } else {
      options!.headers!['authorization'] = "Bearer NO TOKEN";
    }
    options!.headers!['Language'] = get_x.Get.locale?.languageCode ?? 'en';
  }

  Future<Response> download({
    required String path,
    required String filePath,
    void Function(int received, int total)? sendProgress,
    CancelToken? cancelToken,
  }) async {
    final res = await _dio.download(
      path,
      filePath,
      cancelToken: cancelToken,
      onReceiveProgress: sendProgress,
    );
    return res;
  }

  Future<File> downloadFile({required String url, required File file}) async {
    final request = await httpClient.getUrl(Uri.parse(url));
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<Uint8List> downloadFileAsBytes(String url) async {
    final request = await httpClient.getUrl(Uri.parse(url));
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    return bytes;
  }

  Future<Response> get(
    String path, {
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic> body = const <String, dynamic>{},
    Map<String, dynamic> query = const <String, dynamic>{},
    String? saveDirPath,
  }) async {
    return send(
      path: path,
      reqMethod: 'GET',
      body: body,
      query: query,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  Future<Response> post(
    String path, {
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic> body = const <String, dynamic>{},
    Map<String, dynamic> query = const <String, dynamic>{},
    String? saveDirPath,
  }) async {
    return send(
      path: path,
      reqMethod: 'POST',
      body: body,
      query: query,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  Future<Response> put(
    String path, {
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic> body = const <String, dynamic>{},
    Map<String, dynamic> query = const <String, dynamic>{},
    String? saveDirPath,
  }) async {
    return send(
      path: path,
      reqMethod: 'PUT',
      body: body,
      query: query,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  Future<Response> delete(
    String path, {
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic> body = const <String, dynamic>{},
    Map<String, dynamic> query = const <String, dynamic>{},
    String? saveDirPath,
  }) async {
    return send(
      path: path,
      reqMethod: 'DELETE',
      body: body,
      query: query,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  /// send any type of request GET POST PUT PATCH DELETE DOWNLOAD
  Future<Response> send({
    required String reqMethod,
    required String path,
    Function(int count, int total)? onSendProgress,
    Function(int count, int total)? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic> body = const <String, dynamic>{},
    Map<String, dynamic> query = const <String, dynamic>{},
  }) async {
    late Response res;

    final _body = {}..addAll(body);
    final _query = {}..addAll(query);

    try {
      switch (reqMethod.toUpperCase()) {
        case 'GET':
          res = await _dio.get(
            path,
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        case 'POST':
          res = await _dio.post(
            path,
            data: _body.cast(),
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        case 'PUT':
          res = await _dio.put(
            path,
            data: _body.cast(),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        case 'PATCH':
          res = await _dio.patch(
            path,
            data: _body.cast(),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        case 'DELETE':
          res = await _dio.delete(
            path,
            data: _body.cast(),
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        default:
          throw "reqMethod Not available ! ";
      }

      _throwIfNoSuccess(res);

      return res;
    } on DioException catch (err) {
      if (err.type == DioExceptionType.unknown ||
          err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.receiveTimeout ||
          err.type == DioExceptionType.sendTimeout) {
        throw NoInternetException();
      }
      rethrow;
    } finally {
      _dio.close();
    }
  }

  static void _throwIfHttpNoSuccess(http.Response response) {
    if (response.statusCode > 300) {
      if (options!.errorPath != null) {
        String errorMsg;
        try {
          errorMsg =
              (jsonDecode(response.body) as Map)[options!.errorPath].toString();
        } catch (err) {
          throw NoInternetException();
        }
        throw CustomDioException(errorMsg, response.statusCode);
      }
      throw CustomDioException.fromHttpResponse(response);
    }
  }

  void _throwIfNoSuccess(Response response) {
    if (response.statusCode! > 300) {
      if (options!.errorPath != null) {
        String errorMsg;
        try {
          errorMsg = (response.data as Map)[options!.errorPath].toString();
        } catch (err) {
          throw NoInternetException();
        }
        throw CustomDioException(errorMsg, response.statusCode ?? 500);
      }
      throw CustomDioException.fromResponse(response);
    }
  }
}
