import 'package:get/get.dart';

import '../controllers/post_feeling_controller.dart';

class PostFeelingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostFeelingController>(
      () => PostFeelingController(),
    );
  }
}
