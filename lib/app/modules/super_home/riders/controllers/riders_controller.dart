import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/rider_registration_info_model.dart';

class RidersController extends GetxController {
  late final ridersPagingController =
      PagingController<int, RiderRegistrationInfoModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchAdsPage);

  Future<void> _fetchAdsPage(int pageKey) async {
    try {
      final result = await CustomDio(
        enableLog: true,
      ).get('super-admin/riders?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => RiderRegistrationInfoModel.fromMap(e as Map<String, dynamic>))
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

  void showLockDialog(String userId) {
    int days = 0;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Block This User?'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Days',
              onChange: (v) => days = int.tryParse(v) ?? 0,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child: 'Block'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () => lockUser(userId, days),
            )
          ],
        ),
      ),
    );
  }

  void lockUser(String userId, int days) async {
    try {
      Get.back();

      await CustomDio().post(
        'super-admin/lock-user',
        body: {
          'user_id': userId,
          'days': days,
        },
      );
      CustomAlert.snackBar(msg: 'Success User Bocked for $days Days.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteConfirmDialog(RiderRegistrationInfoModel profile) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this Rider?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteRider(profile),
    );
  }

  void deleteRider(RiderRegistrationInfoModel profile) async {
    try {
      Get.back();

      await CustomDio().delete('super-admin/riders/${profile.id}');
      CustomAlert.snackBar(msg: 'Success User Rider Deleted.');
      ridersPagingController.removeItem(profile);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }
}
