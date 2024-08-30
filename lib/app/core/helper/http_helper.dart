import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Add this dependency

import 'package:mime/mime.dart';

import '../models/Http_request_enum.dart';
import '../models/failure_model.dart';
import 'cash_helper.dart';

class HttpHelper {
  static Future<http.Response> postData({
    required String linkUrl,
    required Map data,
    required String? token,
  }) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var response = await http.post(
      Uri.parse(linkUrl),
      body: json.encode(data),
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> getData({
    required String linkUrl,
  }) async {
    var headers = {
      'Accept': 'application/json',
    };
    var response = await http.get(Uri.parse(linkUrl), headers: headers);

    return response;
  }

  static Future<http.Response> putData({
    required String linkUrl,
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var response = await http.put(Uri.parse(linkUrl),
        body: json.encode(data), headers: headers);
    return response;
  }

  static Future<http.Response> patchData({
    required String linkUrl,
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };
    String jsonBody = json.encode(data);
    // final encoding = Encoding.getByName('utf-8');

    var response = await http.patch(Uri.parse(linkUrl),
        body: jsonBody,
        //  encoding: encoding,
        headers: headers);
    return response;
  }

  static Future<http.Response> deleteData(
      // todo: Ask for this exception
          {
        required String linkUrl,
        Map? data,
        required String? token,
      }) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var response =
    await http.delete(Uri.parse(linkUrl), body: data, headers: headers);
    return response;
  }

  static Future<http.Response> patchFile({
    required String linkUrl,
    required File file,
    required String name,
    required String? token,
  }) async {
    try {
      // Log the upload attempt
      print("Attempting to upload file...");

      // Create the multipart request
      var request = http.MultipartRequest('PATCH', Uri.parse(linkUrl));
      request.headers['Authorization'] = 'Bearer $token';

      // Check if file exists
      if (!await file.exists()) {
        throw Exception("File not found at path: ${file.path}");
      }

      print("resss 1");

      // Determine the MIME type of the file
      var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      print("Detected MIME type: $mimeType");

      // Split the MIME type into type and subtype
      var mimeTypeData = mimeType.split('/');
      if (mimeTypeData.length != 2) {
        throw Exception("Invalid MIME type: $mimeType");
      }

      // Add the file to the request
      request.files.add(await http.MultipartFile.fromPath(
        name,
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

      // Send the request
      final response = await request.send();

      // Convert the response to http.Response
      final http.Response res = await http.Response.fromStream(response);

      // Decode the response body
      var resFile = json.decode(res.body);

      // Log the response details
      print("Response Status: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${res.body}");

      // Check for success
      if (response.statusCode != 200) {
        print("Failed to upload file: ${resFile['message']}");
      }

      return res;
    } catch (e) {
      // Log any errors
      print("Error in patchFile: $e");
      rethrow;
    }
  }

  static Future<http.Response> postFile({
    required String linkUrl,
    required File file,
    required String name,
    required String? token,
  }) async {
    try {
      // Log the upload attempt
      print("Attempting to upload file...");

      // Create the multipart request
      var request = http.MultipartRequest('POST', Uri.parse(linkUrl));
      request.headers['Authorization'] = 'Bearer $token';

      // Check if file exists
      if (!await file.exists()) {
        throw Exception("File not found at path: ${file.path}");
      }

      print("resss 1");

      // Determine the MIME type of the file
      var mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      print("Detected MIME type: $mimeType");

      // Split the MIME type into type and subtype
      var mimeTypeData = mimeType.split('/');
      if (mimeTypeData.length != 2) {
        throw Exception("Invalid MIME type: $mimeType");
      }

      // Add the file to the request
      request.files.add(await http.MultipartFile.fromPath(
        name,
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ));

      // Send the request
      final response = await request.send();

      // Convert the response to http.Response
      final http.Response res = await http.Response.fromStream(response);

      // Decode the response body
      var resFile = json.decode(res.body);

      // Log the response details
      print("Response Status: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${res.body}");

      // Check for success
      if (response.statusCode != 200) {
        print("Failed to upload file: ${resFile['message']}");
      }

      return res;
    } catch (e) {
      // Log any errors
      print("Error in patchFile: $e");
      rethrow;
    }
  }

  static Future<Either<FailureModel, Map>> handleRequest(
      Future<http.Response> Function() requestFunction,
      ) async {
    try {



        http.Response response = await requestFunction();

        if (response.statusCode == 200 || response.statusCode == 201) {
          print(
              "++++++++++Backend Response +++++++++++${jsonDecode(response.body)}");
          return Right(jsonDecode(response.body));
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          /// bad request(invalid data).
          String message = jsonDecode(response.body)['message'];
          print('errrrrorrrr mesegr $message');
          return Left(FailureModel(
              responseStatus: HttpResponseStatus.invalidData,
              message: message));
        } else {
          String message = jsonDecode(response.body)['message'];
          print('!!!!!!!!!!!!!!!!!! backend request error: $message');
          return Left(FailureModel(responseStatus: HttpResponseStatus.failure));
        }

    } catch (e) {
      print("requestHandler");
      print(e.toString());
      return Left(FailureModel(responseStatus: HttpResponseStatus.failure));
    }
  }
}
