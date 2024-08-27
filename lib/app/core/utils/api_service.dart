import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = "https://49dev.com/api/v1/dashboard/";


  final Dio _dio;

  ApiService(this._dio);

  Future<Response> post(
      {required body,
        required String url,
        required String token,
        Map<String, String>? headers,
        String? contentType}) async {
    var response = await _dio.post(url,
        data: body,
        options: Options(
          contentType: contentType,
          headers: headers ?? {'Authorization': "Bearer $token"},
        ));

    return response;
  }

  Future<Map<String, dynamic>> getData({required String endPoint, Map<String, dynamic>? headers}) async {

    var response = await _dio.get("$_baseUrl$endPoint",
        options: Options(headers: headers ?? {}));
    return response.data;
  }

  Future<Map<String, dynamic>> getDataWithoutBaseUrl({required String endPoint}) async {
    log(endPoint.toString());
    var response = await _dio.get(endPoint);

    return response.data;
  }

  Future<List<dynamic>> getArrayData(
      {required String endPoint, Map<String, dynamic>? headers}) async {
    var response = await _dio.get("$_baseUrl$endPoint",
        options: Options(headers: headers ?? {}));
    List<dynamic> data = response.data;
    print(response.statusCode);
    return data;
    return response.data;
  }

  Future<Map<String, dynamic>> postData(
      {required String endPoint,
      required Map<String, dynamic> body,
      Map<String, dynamic>? headers}) async {
    log(endPoint);
    var response = await _dio.post("$_baseUrl$endPoint",
        data: body, options: Options(headers: headers ?? {}));
    return response.data;
  }

  Future<Map<String, dynamic>> patchData(
      {required String endPoint,
      required Map<String, dynamic> body,
      Map<String, dynamic>? headers}) async {
    log(endPoint);
    var response = await _dio.patch("$_baseUrl$endPoint",
        data: body, options: Options(headers: headers ?? {}));
    print("Patch Data "+response.toString());
    return response.data;
  }

  Future<String> patchDataString(
      {required String endPoint,
        required Map<String, dynamic> body,
        Map<String, dynamic>? headers}) async {
    log(endPoint);
    var response = await _dio.patch("$_baseUrl$endPoint",
        data: body, options: Options(headers: headers ?? {}));
    print("Patch Data "+response.toString());
    return response.toString();
  }

  Future<dynamic> patchDataWithReturnDynamic(
      {required String endPoint,
        required Map<String, dynamic> body,
        Map<String, dynamic>? headers}) async {
    log(endPoint);
    var response = await _dio.patch("$_baseUrl$endPoint",
        data: body, options: Options(headers: headers ?? {}));
    return response;
  }

  Future<Map<String, dynamic>> patchDataWithFormData({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic> headers = const {},
  }) async {
    log(endPoint);
    var response = await _dio.patch("$_baseUrl$endPoint",
        data: formData, options: Options(headers: headers ?? {}));
    return response.data;
  }

  Future<Map<String, dynamic>> putData(
      {required String endPoint,
      required Map<String, dynamic> body,
      Map<String, dynamic>? headers}) async {
    log(endPoint);
    var response = await _dio.put("$_baseUrl$endPoint",
        data: body, options: Options(headers: headers ?? {}));
    return response.data;
  }

  Future<dynamic> postDataWithFormData({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic> headers = const {},
  }) async {
    log(endPoint);
    var response = await _dio.post("$_baseUrl$endPoint",
        data: formData, options: Options(headers: headers));
    return response.data;
  }

  Future<Map<String, dynamic>> deleteData(
      {required String endPoint,
      required Map<String, dynamic> body,
      Map<String, dynamic>? headers}) async {
    var response = await _dio.delete("$_baseUrl$endPoint",
        data: body, options: Options(headers: headers ?? {}));
    return response.data;
  }
}
