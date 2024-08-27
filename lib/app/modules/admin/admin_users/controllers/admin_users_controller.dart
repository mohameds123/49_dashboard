import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/base_user.dart';

class AdminUsersController extends GetxController {
  late final usersPagingController =
      PagingController<int, BaseUser>(firstPageKey: 1)
        ..addPageRequestListener(_fetchProfilesPage);

  Future<void> _fetchProfilesPage(int pageKey) async {
    try {
      final result = await CustomDio().get('admin/users?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => BaseUser.fromMap(e as Map<String, dynamic>))
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
    } catch (error) {
      usersPagingController.error = error;
    }
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
                  : sendNotificationToUser(
                      userId, titleAr, titleEn, bodyAr, bodyEn),
            )
          ],
        ),
      ),
    );
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

  void sendNotificationToAll(
      String titleAr, String titleEn, String bodyAr, String bodyEn) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/send-notification-to-all',
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

  @override
  void onClose() {
    usersPagingController.dispose();
    super.onClose();
  }
}
