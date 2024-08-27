import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/doctor_model.dart';
import '../../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class ReviewHealthController extends GetxController {
  late final doctorsPagingController =
      PagingController<int, DoctorModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchDoctorsPage);

  Future<void> _fetchDoctorsPage(int pageKey) async {
    final result = await CustomDio().get('admin/review-health?page=$pageKey');

    final newItemsResult =
        ((result.data as Map<String, dynamic>)['data'] as List)
            .map((e) => DoctorModel.fromMap(e as Map<String, dynamic>))
            .toList();

    final newItems = newItemsResult
        .where((e) => !doctorsPagingController.itemList.contains(e))
        .toList();

    final isLastPage = newItemsResult.isEmpty;
    if (isLastPage) {
      doctorsPagingController.appendLastPage(newItems);
    } else {
      doctorsPagingController.appendPage(newItems, pageKey + 1);
    }
  }

  void onPictureClick(DoctorModel doctor, int index) {
    Get.toNamed(Routes.IMAGES_VIEWER, arguments: [
      [
        doctor.picture,
        doctor.idFront,
        doctor.idBehind,
        doctor.practiceLicenseFront,
        doctor.practiceLicenseBehind,
      ],
      index
    ]);
  }

  void showApproveDialog(DoctorModel doctor) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to approve this Doctor?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => approveDoctor(doctor),
    );
  }

  void approveDoctor(DoctorModel doctor) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/approve-health',
        body: {
          'id': doctor.id,
          'location': doctor.location,
          'specialty': doctor.specialty,
        },
      );
      CustomAlert.snackBar(msg: 'Success Doctor Approved.');
      doctorsPagingController.removeItem(doctor);
      if (Get.isRegistered<HomeController>()) {
        if (Get.find<HomeController>().healthReviewCounts > 0) {
          Get.find<HomeController>().healthReviewCounts.value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showDeclineDialog(DoctorModel doctor) {
    String reasonAr = '';
    String reasonEn = '';

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Decline Doctor'.text,
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
              onPressed: () => declineDoctor(doctor, reasonAr, reasonEn),
            )
          ],
        ),
      ),
    );
  }

  void declineDoctor(
      DoctorModel doctor, String reasonAr, String reasonEn) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/decline-health',
        body: {
          'id': doctor.id,
          'reason_ar': reasonAr,
          'reason_en': reasonEn,
        },
      );
      CustomAlert.snackBar(msg: 'Success Doctor Declined.');
      doctorsPagingController.removeItem(doctor);
      if (Get.isRegistered<HomeController>()) {
        if (Get.find<HomeController>().healthReviewCounts > 0) {
          Get.find<HomeController>().healthReviewCounts.value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
    doctorsPagingController.dispose();
    super.onClose();
  }
}
