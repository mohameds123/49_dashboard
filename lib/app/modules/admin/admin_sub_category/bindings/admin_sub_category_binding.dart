import 'package:get/get.dart';

import '../controllers/admin_sub_category_controller.dart';

class AdminSubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSubCategoryController>(
      () => AdminSubCategoryController(),
    );
  }
}
