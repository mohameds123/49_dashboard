import 'package:get/get.dart';

import '../controllers/add_sub_category_controller.dart';

class AddSubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSubCategoryController>(
      () => AddSubCategoryController(Get.arguments as String),
    );
  }
}
