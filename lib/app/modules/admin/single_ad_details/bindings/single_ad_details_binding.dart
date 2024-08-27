import 'package:get/get.dart';

import '../../../../data/model/dynamic/dynamic_ad_model.dart';
import '../controllers/single_ad_details_controller.dart';

class SingleAdDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleAdDetailsController>(
      () => SingleAdDetailsController(Get.arguments as DynamicAdModel),
    );
  }
}
