import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../../core/constants.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../routes/app_pages.dart';



class ChangeUserNameAndPassController extends GetxController {
  String? username;
  String? currentPassword;
  String? newPassword;
  String? confirmNewPassword;


  Future<void> changeUserName() async {
    final dio = Dio();
    const String url = "${AppConstants.baseUrl}/api/v1/users";

    final data = {
      'username': username,
    };

    try {
      final response = await dio.put(url, data: data);

      if (response.statusCode == 200) {
        // Handle success response
        print('changeUserName successful: ${response.data}');
        return CustomAlert.showError('User Name Was Changed Successfully');

      } else {
        // Handle non-200 status codes
        return CustomAlert.showError('Something Wrong, Try Again !!');
      }
    } on DioException catch (e) {
      // Handle Dio errors

      print('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      // Handle any other errors

      print('Unexpected error: $e');
    }
  }
  Future<void> changePassword() async {
    final dio = Dio();
    const String url = "${AppConstants.baseUrl}/api/v1/auth/change-password";

    final data = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };

    try {
      final response = await dio.put(url, data: data);

      if (response.statusCode == 200) {
        // Handle success response
        print('changePassword successful: ${response.data}');
        return CustomAlert.showError('Password Was Changed Successfully');


      } else {
        // Handle non-200 status codes
        return CustomAlert.showError('Something Wrong, Try Again !!');
      }
    } on DioException catch (e) {
      // Handle Dio errors

      print('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      // Handle any other errors

      print('Unexpected error: $e');
    }
  }
}
