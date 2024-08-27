import 'package:get/get.dart';

import '../controllers/pick_me_trips_controller.dart';

class PickMeTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickMeTripsController>(
      () => PickMeTripsController(),
    );
  }
}
