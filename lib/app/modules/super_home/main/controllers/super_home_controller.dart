import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../routes/app_pages.dart';

class SuperHomeController extends GetxController {
  final statistics = RxMap<String, int>();

  Future<void> getStatistics() async {
    try {
      final result = await CustomDio().get('super-admin/statistics');
      statistics.value = result.data['data'].cast<String, int>();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showLogoutConfirmDialog() {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        AppConstants.storage.deleteAll();
        Get.offNamed(Routes.LOGIN);
      },
    );
  }


  void sendNotificationToUser(
      String userId,
      String titleAr,
      String titleEn,
      String bodyAr,
      String bodyEn,
      ) async {
    try {
      Get.back();
      await CustomDio().post(
        'super-admin/send-notification',
        body: {
          'user_id': userId,
          'title_ar': titleAr,
          'title_en': titleEn,
          'body_ar': bodyAr,
          'body_en': bodyEn,
        },
      );
      CustomAlert.snackBar(msg: 'Success Send Notification.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }
  @override
  void onInit() {
    getStatistics();
    super.onInit();
  }
}
