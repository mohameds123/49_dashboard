import 'package:get/get.dart';

import '../controllers/review_come_with_me_trips_controller.dart';

class ReviewComeWithMeTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewComeWithMeTripsController>(
      () => ReviewComeWithMeTripsController(),
    );
  }
}
