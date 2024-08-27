import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fourtynine_dashboard/app/modules/super_home/main/controllers/super_home_controller.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/profile_model.dart';

class UsersController extends GetxController {
  late final usersPagingController =
      PagingController<int, ProfileModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchProfilesPage);

  Future<void> _fetchProfilesPage(int pageKey) async {
    try {

      final result = await CustomDio().get('main-wallet/66a40f0d88dc22dcdbd14202');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => ProfileModel.fromMap(e as Map<String, dynamic>))
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

      //6307f670f04686287ac09bea
      //6318f624a95153b33ff5a480
      //6318f624a95153b33ff5a480
    } catch (error) {
      usersPagingController.error = error;
    }
  }

  void showLockDialog(ProfileModel profile) {
    int days = 0;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Block ${profile.fullName}'.text,
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
              onPressed: () => lockUser(profile, days),
            )
          ],
        ),
      ),
    );
  }

  void showUnLockDialog(ProfileModel profile) {
    Get.defaultDialog(
      title: 'Un Block',
      middleText: 'Un Block (${profile.fullName})?',
      textConfirm: 'Un Block',
      confirmTextColor: Colors.white,
      textCancel: 'Cancel',
      onConfirm: () => unLockUser(profile),
    );
  }

  void showDeleteDialog(ProfileModel profile) {
    Get.defaultDialog(
      title: 'Delete User',
      middleText: 'Delete (${profile.fullName})?',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      textCancel: 'Cancel',
      onConfirm: () => deleteUser(profile),
    );
  }

  void showNotificationDialog({String? userId}) {
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
              onPressed: () => userId == null
                  ? sendNotificationToAll(titleAr, titleEn, bodyAr, bodyEn)
                  : Get.find<SuperHomeController>().sendNotificationToUser(
                      userId, titleAr, titleEn, bodyAr, bodyEn),
            )
          ],
        ),
      ),
    );
  }

  void sendNotificationToAll(
      String titleAr, String titleEn, String bodyAr, String bodyEn) async {
    try {
      Get.back();
      await CustomDio().post(
        'super-admin/send-notification-to-all',
        body: {
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

  void lockUser(ProfileModel profile, int days) async {
    try {
      Get.back();

      await CustomDio().post(
        'super-admin/lock-user',
        body: {
          'user_id': profile.id,
          'days': days,
        },
      );
      CustomAlert.snackBar(msg: 'Success User Bocked.');

      profile.lockedDays += days;
      profile.isLocked = true;
      usersPagingController.refreshItems();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void unLockUser(ProfileModel profile) async {
    try {
      Get.back();

      await CustomDio().post(
        'super-admin/unlock-user',
        body: {
          'user_id': profile.id,
        },
      );
      CustomAlert.snackBar(msg: 'Success User Un Bocked.');

      profile.lockedDays = 0;
      profile.isLocked = false;
      usersPagingController.refreshItems();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void deleteUser(ProfileModel profile) async {
    try {
      Get.back();

      await CustomDio().delete('super-admin/users/${profile.id}');
      CustomAlert.snackBar(msg: 'Success User Un Deleted.');

      usersPagingController.removeItem(profile);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showSubscribeDialog(ProfileModel profile) {
    String? categoryId;
    int days = 3;
    bool isPremium = false;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Give ${profile.fullName} Subscription'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Sub Category Id',
              onChange: (v) => categoryId = v,
              textInputType: TextInputType.text,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Days',
              initValue: '3',
              onChange: (v) => days = int.tryParse(v) ?? 0,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ValueBuilder<bool?>(
              initialValue: isPremium,
              onUpdate: (v) => isPremium = v!,
              builder: (value, update) => SwitchListTile(
                title: 'is Premium'.text,
                value: value!,
                onChanged: update,
              ),
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
              onPressed: () {
                if (categoryId != null && categoryId!.length > 2 && days > 0) {
                  Get.back();
                  giveUserSubscription(
                      profile.id, categoryId!, days, isPremium);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void giveUserSubscription(
      String userId, String categoryId, int days, bool isPremium) async {
    try {
      await CustomDio().post(
        'super-admin/give-user-subscription',
        body: {
          'user_id': userId,
          'category_id': categoryId,
          'days': days,
          'is_premium': isPremium,
        },
      );
      CustomAlert.snackBar(msg: 'Success User Got Subscription.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
    usersPagingController.dispose();
    super.onClose();
  }
}
