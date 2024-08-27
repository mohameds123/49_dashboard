import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/dynamic/dynamic_ad_model.dart';
import '../../home/controllers/home_controller.dart';

class ReviewAdsController extends GetxController {
  late final adsPagingController =
      PagingController<int, DynamicAdModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchAdsPage);

  Future<void> _fetchAdsPage(int pageKey) async {
    try {
      final result = await CustomDio(enableLog: true).get('admin/review-ads?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => DynamicAdModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !adsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        adsPagingController.appendLastPage(newItems);
      } else {
        adsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      adsPagingController.error = error;
    }
  }

  void showDeclineAdDialog(DynamicAdModel dynamicAd, bool isFromDetailsScreen) {
    String reasonAr = '';
    String reasonEn = '';

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Decline Ad'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Reason Ar',
              onChange: (v) => reasonAr = v,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Reason En',
              onChange: (v) => reasonEn = v,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child: 'Decline'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () =>
                  declineAd(dynamicAd, reasonAr, reasonEn, isFromDetailsScreen),
            )
          ],
        ),
      ),
    );
  }

  void showApproveAdDialog(
      DynamicAdModel ad, List<String> pictures, bool isFromDetailsScreen) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'are you sure you want to approve this ad?',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      textCancel: 'No',
      onConfirm: () => approveAd(ad, pictures, isFromDetailsScreen),
    );
  }

  void declineAd(DynamicAdModel ad, String reasonAr, String reasonEn,
      bool isFromDetailsScreen) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/decline-ad',
        body: {
          'id': ad.id,
          'reason_ar': reasonAr,
          'reason_en': reasonEn,
        },
      );
      CustomAlert.snackBar(msg: 'Success Ad Declined.');
      if (Get.isRegistered<HomeController>()) {
        if (Get
            .find<HomeController>()
            .adsReviewCounts > 0) {
          Get
              .find<HomeController>()
              .adsReviewCounts
              .value--;
        }
      }
      adsPagingController.removeItem(ad);
      if (isFromDetailsScreen) {
        Get.back();
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void approveAd(DynamicAdModel ad, List<String> pictures,
      bool isFromDetailsScreen) async {
    try {
      Get.back();
      await CustomDio().post('admin/approve-ad', body: {
        'id': ad.id,
        'pictures': pictures
            .map((e) => e.replaceAll(AppConstants.imageBaseUrl, ''))
            .toList(),
      });
      CustomAlert.snackBar(msg: 'Success Ad Approved.');
      if (Get.isRegistered<HomeController>()) {
        Get
            .find<HomeController>()
            .adsReviewCounts
            .value--;
      }
      adsPagingController.removeItem(ad);
      if (isFromDetailsScreen) {
        Get.back();
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
    adsPagingController.dispose();
    super.onClose();
  }
}
