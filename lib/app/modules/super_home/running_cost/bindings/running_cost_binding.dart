import 'package:get/get.dart';

import '../controllers/running_cost_controller.dart';

class RunningCostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RunningCostController>(
      () => RunningCostController(),
    );
  }
}
