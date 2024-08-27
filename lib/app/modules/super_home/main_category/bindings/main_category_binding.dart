import 'package:get/get.dart';

import '../controllers/main_category_controller.dart';

class MainCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainCategoryController>(
      () => MainCategoryController(),
    );
  }
}
