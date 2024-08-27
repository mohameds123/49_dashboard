import 'package:get/get.dart';

import '../controllers/images_viewer_controller.dart';

class ImagesViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagesViewerController>(
      () => ImagesViewerController(Get.arguments[0], Get.arguments[1]),
    );
  }
}
