import 'package:get/get.dart';

import '../controllers/dynamic_props_controller.dart';

class DynamicPropsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicPropsController>(
      () => DynamicPropsController(),
    );
  }
}
