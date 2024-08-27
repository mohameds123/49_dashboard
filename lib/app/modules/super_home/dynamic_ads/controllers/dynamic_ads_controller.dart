import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/dynamic/dynamic_ad_model.dart';
import '../../../../data/model/main_category_model.dart';

class DynamicAdsController extends GetxController {
  final mainCategories = RxList<MainCategoryModel>();

  String? currentMainCategory;

  late final adsPagingController =
      PagingController<int, DynamicAdModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchAdsPage);

  void getMainCategories() async {
    try {
      final result = await CustomDio().get('super-admin/main-categories');

      final data = (result.data['data'] as List)
          .map((e) => MainCategoryModel.fromMap(e))
          .toList();
      data.sort((a, b) => a.index.compareTo(b.index));
      mainCategories.value = data.sublist(4);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void onMainCategoryChanged(String? mainCategoryId) {
    currentMainCategory = mainCategoryId;
    if (currentMainCategory != null) {
      adsPagingController.refresh();
    }
  }

  Future<void> _fetchAdsPage(int pageKey) async {
    try {
      if (currentMainCategory == null)
        return adsPagingController.appendLastPage([]);
      final result = await CustomDio(
        enableLog: true,
      ).get('super-admin/dynamic-ads/$currentMainCategory?page=$pageKey');

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

  void showDeleteConfirmDialog(DynamicAdModel dynamicAd) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this Ad?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteAd(dynamicAd),
    );
  }

  void deleteAd(DynamicAdModel dynamicAd) async {
    try {
      Get.back();

      await CustomDio().delete('super-admin/dynamic-ads/${dynamicAd.id}');
      CustomAlert.snackBar(msg: 'Success User Ad Deleted.');
      adsPagingController.removeItem(dynamicAd);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onInit() {
    getMainCategories();
    super.onInit();
  }
}
