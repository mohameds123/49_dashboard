import 'package:get/get.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/food_item_model.dart';
import '../../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class ReviewFoodController extends GetxController {
  late final foodsPagingController =
      PagingController<int, FoodItemModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchFoodsPage);

  Future<void> _fetchFoodsPage(int pageKey) async {
    try {
      final result = await CustomDio().get('admin/review-food?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => FoodItemModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !foodsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        foodsPagingController.appendLastPage(newItems);
      } else {
        foodsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      foodsPagingController.error = error;
    }
  }

  void onPictureClick(FoodItemModel food) {
    Get.toNamed(
      Routes.IMAGES_VIEWER,
      arguments: [
        [food.picture],
        0
      ],
    );
  }

  void approve(FoodItemModel food) async {
    try {
      await CustomDio().post('admin/approve-food', body: {
        'id': food.id,
        'name': food.name,
        'desc': food.desc,
      });
      CustomAlert.snackBar(msg: 'Success Food Approved.');
      foodsPagingController.removeItem(food);
      if (Get.isRegistered<HomeController>()) {
        if (Get
            .find<HomeController>()
            .foodReviewCounts > 0) {
          Get
              .find<HomeController>()
              .foodReviewCounts
              .value--;
        }
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void decline(FoodItemModel food) async {
    try {
      await CustomDio().post(
        'admin/decline-food',
        body: {
          'id': food.id,
        },
      );
      CustomAlert.snackBar(msg: 'Success Food Declined.');
      foodsPagingController.removeItem(food);
      if (Get.find<HomeController>().foodReviewCounts > 0) {
        Get.find<HomeController>().foodReviewCounts.value--;
      }
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
    foodsPagingController.dispose();
    super.onClose();
  }
}
