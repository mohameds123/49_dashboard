import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/rider_registration_info_model.dart';
import '../../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class ReviewRideController extends GetxController {
  late final ridersPagingController =
      PagingController<int, RiderRegistrationInfoModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchRidersPage);

  Future<void> _fetchRidersPage(int pageKey) async {
    try {
      final result = await CustomDio(enableLog: true)
          .get('admin/review-riders?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) =>
                  RiderRegistrationInfoModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !ridersPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        ridersPagingController.appendLastPage(newItems);
      } else {
        ridersPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      ridersPagingController.error = error;
    }
  }

  void onPictureClick(RiderRegistrationInfoModel rider, int index) {
    final pictures = [
      ...rider.carPictures,
      rider.idFront,
      rider.idBehind,
      rider.drivingLicenseFront,
      rider.drivingLicenseBehind,
      rider.carLicenseFront,
      rider.carLicenseBehind,
    ];

    if (rider.criminalRecord != null) pictures.add(rider.criminalRecord!);
    if (rider.technicalExamination != null)
      pictures.add(rider.technicalExamination!);
    if (rider.drugAnalysis != null) pictures.add(rider.drugAnalysis!);
    Get.toNamed(Routes.IMAGES_VIEWER, arguments: [pictures, index]);
  }

  void showApproveDialog(RiderRegistrationInfoModel rider) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to approve this rider?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => approveRider(rider),
    );
  }

  void approveRider(RiderRegistrationInfoModel rider) async {
    try {
      Get.back();
      await CustomDio().post('admin/approve-rider', body: rider.toMap());
      CustomAlert.snackBar(msg: 'Success Rider Approved.');
      ridersPagingController.removeItem(rider);
      if (Get.isRegistered<HomeController>()) {
        if (Get.find<HomeController>().rideReviewCounts > 0) {
          Get.find<HomeController>().rideReviewCounts.value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showDeclineDialog(RiderRegistrationInfoModel rider) {
    String reasonAr = '';
    String reasonEn = '';

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Decline Rider'.text,
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
              onPressed: () => declineRider(rider, reasonAr, reasonEn),
            )
          ],
        ),
      ),
    );
  }

  void declineRider(RiderRegistrationInfoModel rider, String reasonAr,
      String reasonEn) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/decline-rider',
        body: {
          'id': rider.id,
          'reason_ar': reasonAr,
          'reason_en': reasonEn,
        },
      );
      CustomAlert.snackBar(msg: 'Success Rider Declined.');
      ridersPagingController.removeItem(rider);
      if (Get.isRegistered<HomeController>()) {
        if (Get.find<HomeController>().rideReviewCounts > 0) {
          Get.find<HomeController>().rideReviewCounts.value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
    ridersPagingController.dispose();
    super.onClose();
  }
}
