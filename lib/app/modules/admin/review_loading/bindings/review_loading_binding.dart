import 'package:get/get.dart';

import '../controllers/review_loading_controller.dart';

class ReviewLoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewLoadingController>(
      () => ReviewLoadingController(),
    );
  }
}
