import 'package:get/get.dart';

import '../controllers/review_health_controller.dart';

class ReviewHealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewHealthController>(
      () => ReviewHealthController(),
    );
  }
}
