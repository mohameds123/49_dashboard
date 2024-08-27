import 'package:get/get.dart';
import '../controllers/single_post_controller.dart';

class SinglePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SinglePostController>(
      () => SinglePostController(Get.arguments as String),
      tag: Get.arguments as String,
    );
  }
}
