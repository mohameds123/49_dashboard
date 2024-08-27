import 'package:get/get.dart';

import '../../../../data/model/profile_model.dart';
import '../controllers/user_details_controller.dart';

class UserDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailsController>(
      () => UserDetailsController(Get.arguments as ProfileModel),
    );
  }
}
