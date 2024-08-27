import 'package:get/get.dart';

import '../controllers/change_user_name_and_pass_controller.dart';

class ChangeUserNameAndPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeUserNameAndPassController>(
      () => ChangeUserNameAndPassController(),
    );
  }
}
