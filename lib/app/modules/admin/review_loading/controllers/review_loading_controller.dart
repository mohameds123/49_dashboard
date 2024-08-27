import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/loading_model.dart';
import '../../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class ReviewLoadingController extends GetxController {
  late final loadingsPagingController =
      PagingController<int, LoadingModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchLoadingsPage);

  Future<void> _fetchLoadingsPage(int pageKey) async {
    try {
      final result =
          await CustomDio().get('admin/review-loading?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => LoadingModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !loadingsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        loadingsPagingController.appendLastPage(newItems);
      } else {
        loadingsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      loadingsPagingController.error = error;
    }
  }

  void onPictureClick(LoadingModel loading, int index) {
    final pictures = [
      ...loading.carPictures,
      loading.idFront,
      loading.idBehind,
      loading.drivingLicenseFront,
      loading.drivingLicenseBehind,
      loading.carLicenseFront,
      loading.carLicenseBehind,
    ];
    Get.toNamed(Routes.IMAGES_VIEWER, arguments: [pictures, index]);
  }

  void showApproveDialog(LoadingModel loading) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to approve this loading?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => approveLoading(loading),
    );
  }

  void approveLoading(LoadingModel loading) async {
    try {
      Get.back();
      await CustomDio().post('admin/approve-loading', body: loading.toMap());
      CustomAlert.snackBar(msg: 'Success loading Approved.');
      loadingsPagingController.removeItem(loading);
      if (Get.isRegistered<HomeController>()) {
        if (Get
            .find<HomeController>()
            .loadingReviewCounts > 0) {
          Get
              .find<HomeController>()
              .loadingReviewCounts
              .value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showDeclineDialog(LoadingModel loading) {
    String reasonAr = '';
    String reasonEn = '';

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Decline Loading'.text,
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
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () => declineLoading(loading, reasonAr, reasonEn),
            )
          ],
        ),
      ),
    );
  }

  void declineLoading(
      LoadingModel loading, String reasonAr, String reasonEn) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/decline-loading',
        body: {
          'id': loading.id,
          'reason_ar': reasonAr,
          'reason_en': reasonEn,
        },
      );
      CustomAlert.snackBar(msg: 'Success Loading Declined.');
      loadingsPagingController.removeItem(loading);
      if (Get.isRegistered<HomeController>()) {
        if (Get
            .find<HomeController>()
            .loadingReviewCounts > 0) {
          Get
              .find<HomeController>()
              .loadingReviewCounts
              .value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
    loadingsPagingController.dispose();
    super.onClose();
  }
}
