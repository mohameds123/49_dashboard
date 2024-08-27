import 'package:get/get.dart';

import '../controllers/loadings_controller.dart';

class LoadingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingsController>(
      () => LoadingsController(),
    );
  }
}
