import 'package:get/get.dart';

import '../controllers/user_referrals_controller.dart';

class UserReferralsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserReferralsController>(
      () => UserReferralsController(Get.arguments),
    );
  }
}
