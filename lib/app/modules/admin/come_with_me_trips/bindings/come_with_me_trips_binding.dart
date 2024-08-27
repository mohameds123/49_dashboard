import 'package:get/get.dart';

import '../controllers/come_with_me_trips_controller.dart';

class ComeWithMeTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComeWithMeTripsController>(
      () => ComeWithMeTripsController(),
    );
  }
}
