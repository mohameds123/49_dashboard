import 'package:get/get.dart';

import '../controllers/review_pick_me_trips_controller.dart';

class ReviewPickMeTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewPickMeTripsController>(
      () => ReviewPickMeTripsController(),
    );
  }
}
