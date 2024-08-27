import 'package:get/get.dart';

import '../controllers/review_restaurant_controller.dart';

class ReviewRestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewRestaurantController>(
      () => ReviewRestaurantController(),
    );
  }
}
