import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../core/constants.dart';
import '../../../core/custom_dio/dio_manager.dart';
import '../../../core/custom_dio/src/custom_dio.dart';
import '../../../core/utils/shared_pref_helper.dart';
import '../../../core/widget/custom_alert.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  String? username;
  String? password;

  Future<void> loginUser() async {
    final dio = Dio();
    const String url = 'https://49dev.com/api/v1/auth/login';

    final data = {
      'email': username,
      'password': password,
      'fcmToken': await FirebaseMessaging.instance.getToken(),
    };

    try {
      final response = await dio.post(url, data: data);

      if (response.statusCode == 200) {
        SharedPreferencesHelper.setData(
            userKeyNameSharedPref, jsonEncode(response.data));
        // Handle success response
        print('Login successful: ${response.data}');
        Get.offNamed(Routes.SUPER_HOME);
      } else {
        // Handle non-200 status codes
        return CustomAlert.showError('Info Not Match');
        print('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle Dio errors

      print('Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      // Handle any other errors

      print('Unexpected error: $e');
    }
  }

  void login() async {
    try {
      if (username == null ||
          username!.length < 5 ||
          password == null ||
          password!.length < 5) {
        print(username);
        print(password);
        return CustomAlert.showError('Info Not Match');
      }
      CustomAlert.customLoadingDialog();

      final result = await CustomDio(enableLog: true).post(
        'https://49dev.com/api/v1/auth/login',
        body: {
          'email': username,
          'password': password,
          'fcmToken': await FirebaseMessaging.instance.getToken(),
        },
      );

      Get.closeAllSnackbars();
      Get.back();

      await AppConstants.storage.write(
          key: AppConstants.tokenStorageKey,
          value:
              (result.data['data'] as Map<String, dynamic>)['token'] as String);
      DioManager.setUpDioOptions(
          token: (result.data['data'] as Map<String, dynamic>)['token']);

      if ((result.data as Map<String, dynamic>)['data']['is_super_admin'] ==
          true) {
        await AppConstants.storage
            .write(key: AppConstants.isSuperAdminStorageKey, value: 'true');
        Get.offNamed(Routes.SUPER_HOME);
      } else {
        Get.offNamed(Routes.HOME);
      }
    } catch (e) {
      Get.closeAllSnackbars();
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }
}
