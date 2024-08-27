import 'package:get/get.dart';

import '../controllers/dynamic_ads_controller.dart';

class DynamicAdsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicAdsController>(
      () => DynamicAdsController(),
    );
  }
}
