import 'package:get/get.dart';

import '../controllers/riders_controller.dart';

class RidersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RidersController>(
      () => RidersController(),
    );
  }
}
