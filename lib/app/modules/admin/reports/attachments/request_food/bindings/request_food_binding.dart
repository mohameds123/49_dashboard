import 'package:get/get.dart';
import '../controllers/request_food_controller.dart';

class RequestFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestFoodController>(
      () => RequestFoodController(Get.arguments),
      tag: Get.arguments,
    );
  }
}
