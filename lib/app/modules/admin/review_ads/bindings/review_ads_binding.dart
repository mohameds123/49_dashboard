import 'package:get/get.dart';

import '../controllers/review_ads_controller.dart';

class ReviewAdsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewAdsController>(
      () => ReviewAdsController(),
    );
  }
}
