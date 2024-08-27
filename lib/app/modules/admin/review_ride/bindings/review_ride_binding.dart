import 'package:get/get.dart';

import '../controllers/review_ride_controller.dart';

class ReviewRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewRideController>(
      () => ReviewRideController(),
    );
  }
}
