import 'package:get/get.dart';

import '../controllers/other_user_profile_controller.dart';

class OtherUserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherUserProfileController>(
      () => OtherUserProfileController(Get.arguments as String),
      tag: Get.arguments as String,
    );
  }
}
