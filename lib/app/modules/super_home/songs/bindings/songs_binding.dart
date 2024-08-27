import 'package:get/get.dart';

import '../controllers/songs_controller.dart';

class SongsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongsController>(
      () => SongsController(),
    );
  }
}
