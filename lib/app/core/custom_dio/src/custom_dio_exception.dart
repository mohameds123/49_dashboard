import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class CustomDioException implements Exception {
  Object data;
  int code;

  CustomDioException(this.data, this.code);

  factory CustomDioException.fromResponse(Response res) {
    try {
      return CustomDioException(
        (res.data as Map<String, dynamic>)['message'].toString(),
        res.statusCode ?? 500,
      );
    } catch (err) {
      return CustomDioException(
          "$res is not valid error response from server", 500);
    }
  }

  factory CustomDioException.fromHttpResponse(http.Response res) {
    try {
      return CustomDioException(
        (jsonDecode(res.body) as Map<String, dynamic>)['message'] as String,
        res.statusCode,
      );
    } catch (err) {
      return CustomDioException(
          "$res is not valid error response from server", 500);
    }
  }

  @override
  String toString() {
    return data.toString();
  }
}

class NoInternetException extends CustomDioException {
  ///todo translate
  NoInternetException()
      : super(
          "No internet connection.",
          500,
        );
}
