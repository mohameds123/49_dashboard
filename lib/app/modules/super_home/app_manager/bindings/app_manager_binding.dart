import 'package:get/get.dart';

import '../controllers/app_manager_controller.dart';

class AppManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppManagerController>(
      () => AppManagerController(),
    );
  }
}
