import 'package:get/get.dart';

import '../controllers/admin_main_category_controller.dart';

class AdminMainCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminMainCategoryController>(
      () => AdminMainCategoryController(),
    );
  }
}
