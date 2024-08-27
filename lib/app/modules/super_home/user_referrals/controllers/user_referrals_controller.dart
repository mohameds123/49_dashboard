import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/profile_model.dart';
import '../../../../data/model/referral_model.dart';

class UserReferralsController extends GetxController {
  final ProfileModel profile;

  final totalUnique = Rx(0);
  late final usersPagingController =
      PagingController<int, ReferralModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchUsersPage);

  UserReferralsController(this.profile);

  void getTotalUnique() async {
    try {
      final result = await CustomDio(enableLog: true)
          .get('super-admin/get-referral-unique-count/${profile.id}');

      totalUnique.value = result.data['data'];
    } catch (e) {}
  }

  Future<void> _fetchUsersPage(int pageKey) async {

      final result = await CustomDio(
        enableLog: true,
      ).get(
          'super-admin/get-referral-users/${profile.id}?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => ReferralModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !usersPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        usersPagingController.appendLastPage(newItems);
      } else {
        usersPagingController.appendPage(newItems, pageKey + 1);
      }

  }

  void showNotificationDialog(String userId) {
    String titleAr = '';
    String titleEn = '';
    String bodyAr = '';
    String bodyEn = '';

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFieldWithBackground(
              label: 'Title Ar',
              onChange: (v) => titleAr = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Title En',
              onChange: (v) => titleEn = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Body Ar',
              onChange: (v) => bodyAr = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Body En',
              onChange: (v) => bodyEn = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child: 'Send'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () => sendNotificationToUser(
                  userId, titleAr, titleEn, bodyAr, bodyEn),
            )
          ],
        ),
      ),
    );
  }

  void showLockDialog(ReferralModel user) {
    int days = 0;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Block ${user.fullName}'.text,
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
              onPressed: () => lockUser(user.id, days),
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

  void showUnLockDialog(ReferralModel user) {
    Get.defaultDialog(
      title: 'Un Block',
      middleText: 'Un Block (${user.fullName})?',
      textConfirm: 'Un Block',
      confirmTextColor: Colors.white,
      textCancel: 'Cancel',
      onConfirm: () => unLockUser(user),
    );
  }

  void showDeleteDialog(ReferralModel user) {
    Get.defaultDialog(
      title: 'Delete User',
      middleText: 'Delete (${user.fullName})?',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      textCancel: 'Cancel',
      onConfirm: () => deleteUser(user),
    );
  }

  void deleteUser(ReferralModel user) async {
    try {
      Get.back();

      await CustomDio().delete('super-admin/users/${user.id}');
      CustomAlert.snackBar(msg: 'Success User Un Deleted.');

      usersPagingController.removeItem(user);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }
  void unLockUser(ReferralModel user) async {
    try {
      Get.back();

      await CustomDio().post(
        'super-admin/unlock-user',
        body: {
          'user_id': user.id,
        },
      );
      CustomAlert.snackBar(msg: 'Success User Un Bocked.');

      user.lockedDays = 0;
      usersPagingController.refreshItems();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void sendNotificationToUser(String userId, String titleAr, String titleEn,
      String bodyAr, String bodyEn) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/send-notification',
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
    getTotalUnique();
    super.onInit();
  }
}
