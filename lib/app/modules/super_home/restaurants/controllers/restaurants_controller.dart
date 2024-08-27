import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/restaurant_model.dart';

class RestaurantsController extends GetxController {
  late final restaurantsPagingController =
  PagingController<int, RestaurantModel>(firstPageKey: 1)
    ..addPageRequestListener(_fetchAdsPage);

  Future<void> _fetchAdsPage(int pageKey) async {
    try {
      final result = await CustomDio(
        enableLog: true,
      ).get('super-admin/restaurants?page=$pageKey');

      final newItemsResult =
      ((result.data as Map<String, dynamic>)['data'] as List)
          .map((e) => RestaurantModel.fromMap(e as Map<String, dynamic>))
          .toList();

      final newItems = newItemsResult
          .where((e) => !restaurantsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        restaurantsPagingController.appendLastPage(newItems);
      } else {
        restaurantsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      restaurantsPagingController.error = error;
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

  void showDeleteConfirmDialog(RestaurantModel profile) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this Restaurant?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteRestaurant(profile),
    );
  }

  void deleteRestaurant(RestaurantModel profile) async {
    try {
      Get.back();

      await CustomDio().delete('super-admin/restaurants/${profile.id}');
      CustomAlert.snackBar(msg: 'Success Restaurant Deleted.');
      restaurantsPagingController.removeItem(profile);
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }
}
