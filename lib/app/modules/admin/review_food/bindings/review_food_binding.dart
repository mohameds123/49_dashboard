import 'package:get/get.dart';

import '../controllers/review_food_controller.dart';

class ReviewFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewFoodController>(
      () => ReviewFoodController(),
    );
  }
}
