import 'package:get/get.dart';

import '../controllers/app_radio_controller.dart';

class AppRadioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppRadioController>(
      () => AppRadioController(),
    );
  }
}
