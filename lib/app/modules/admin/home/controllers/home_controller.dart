import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../routes/app_pages.dart';
import '../../dynamic_props/controllers/dynamic_props_controller.dart';

class HomeController extends GetxController {
  final adsReviewCounts = Rx(0);
  final rideReviewCounts = Rx(0);
  final loadingReviewCounts = Rx(0);
  final restaurantsReviewCounts = Rx(0);
  final foodReviewCounts = Rx(0);
  final healthReviewCounts = Rx(0);
  final reportsCounts = Rx(0);

  Future<void> getData() async {
    try {
      final result = await CustomDio().get('admin/review-count');

      adsReviewCounts.value = result.data['data']['ads'];
      rideReviewCounts.value = result.data['data']['ride'];
      loadingReviewCounts.value = result.data['data']['loading'];
      restaurantsReviewCounts.value = result.data['data']['restaurant'];
      foodReviewCounts.value = result.data['data']['food'];
      healthReviewCounts.value = result.data['data']['health'];
      reportsCounts.value = result.data['data']['report'];
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void check() async {
    try {
      final result = await CustomDio().get('admin/check');
      if (result.data['status'] != true) logout();
    } catch (e) {
      logout();
    }
  }

  void logout() async {
    AppConstants.storage.deleteAll();
    Get.offAllNamed(Routes.LOGIN);
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

  @override
  void onInit() {
    check();
    getData();
    Get.put(DynamicPropsController());
    super.onInit();
  }
}
