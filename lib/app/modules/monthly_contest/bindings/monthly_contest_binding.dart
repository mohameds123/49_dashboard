import 'package:get/get.dart';

import '../controllers/monthly_contest_controller.dart';

class MonthlyContestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MonthlyContestController>(
      () => MonthlyContestController(),
    );
  }
}
