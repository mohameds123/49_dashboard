import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_state.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../../../core/widget/custom_alert.dart';
import '../../../../../../data/model/food_item_model.dart';
import '../../../../../../data/model/restaurant_model.dart';

class RequestFoodController extends GetxController {
  final String restaurantId;
  final state = CustomState().obs;

  late RestaurantModel restaurant;

  final pageController = PageController();
  final currentSliderIndex = Rx(0);

  final foodItems = RxList<FoodItemModel>();

  final selectedFoods = RxList<String>();

  RequestFoodController(this.restaurantId);

  @override
  void onInit() {
    super.onInit();
    getRestaurantData();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> getRestaurantData() async {
    try {
      state.value = CustomLoadingState();
      final result = await CustomDio().get(AppConstants.mainHost +
          '/services/food/get-restaurant/$restaurantId');

      restaurant = RestaurantModel.fromMap(result.data['data']);
      state.value = CustomLoadedState();
      getFoodItems();
    } catch (e) {
      state.value = CustomErrorState(e.toString());
    }
  }

  Future<void> getFoodItems() async {
    try {
      final result = await CustomDio().get(AppConstants.mainHost +
          '/services/food/food-items/${restaurant.userId}');

      foodItems.value = ((result.data as Map<String, dynamic>)['data'] as List)
          .map((e) => FoodItemModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }
}
