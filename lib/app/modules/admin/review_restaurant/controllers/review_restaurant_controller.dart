import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/restaurant_model.dart';
import '../../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class ReviewRestaurantController extends GetxController {
  late final restaurantsPagingController =
      PagingController<int, RestaurantModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchRestaurantsPage);

  Future<void> _fetchRestaurantsPage(int pageKey) async {
    try {
      final result =
          await CustomDio().get('admin/review-restaurant?page=$pageKey');

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

  void onPictureClick(RestaurantModel restaurant, int index) {
    Get.toNamed(Routes.IMAGES_VIEWER, arguments: [restaurant.pictures, index]);
  }

  void showApproveDialog(RestaurantModel restaurant) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to approve this Restaurant?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => approveRestaurant(restaurant),
    );
  }

  void approveRestaurant(RestaurantModel restaurant) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/approve-restaurant',
        body: {
          'id': restaurant.id,
          'location': restaurant.location,
        },
      );
      CustomAlert.snackBar(msg: 'Success Restaurant Approved.');
      restaurantsPagingController.removeItem(restaurant);
      if (Get.isRegistered<HomeController>()) {
        if (Get
            .find<HomeController>()
            .restaurantsReviewCounts > 0) {
          Get
              .find<HomeController>()
              .restaurantsReviewCounts
              .value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showDeclineDialog(RestaurantModel restaurant) {
    String reasonAr = '';
    String reasonEn = '';

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Decline Restaurant'.text,
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
              onPressed: () =>
                  declineRestaurant(restaurant, reasonAr, reasonEn),
            )
          ],
        ),
      ),
    );
  }

  void declineRestaurant(
      RestaurantModel restaurant, String reasonAr, String reasonEn) async {
    try {
      Get.back();
      await CustomDio().post(
        'admin/decline-restaurant',
        body: {
          'id': restaurant.id,
          'reason_ar': reasonAr,
          'reason_en': reasonEn,
        },
      );
      CustomAlert.snackBar(msg: 'Success Restaurant Declined.');
      restaurantsPagingController.removeItem(restaurant);
      if (Get.isRegistered<HomeController>()) {
        if (Get
            .find<HomeController>()
            .restaurantsReviewCounts > 0) {
          Get
              .find<HomeController>()
              .restaurantsReviewCounts
              .value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
    restaurantsPagingController.dispose();
    super.onClose();
  }
}
