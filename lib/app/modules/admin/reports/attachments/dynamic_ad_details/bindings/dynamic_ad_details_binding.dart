import 'package:get/get.dart';
import '../controllers/dynamic_ad_details_controller.dart';

class DynamicAdDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicAdDetailsController>(
      () => DynamicAdDetailsController(
        Get.arguments as String,
      ),
    );
  }
}
