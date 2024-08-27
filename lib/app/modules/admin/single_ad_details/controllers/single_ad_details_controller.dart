import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/enums.dart';
import '../../../../data/model/dynamic/dynamic_ad_model.dart';
import '../../../../data/model/dynamic/dynamic_prop_model.dart';

class SingleAdDetailsController extends GetxController {

  final DynamicAdModel dynamicAd;

  late final pictures = RxList<String>(dynamicAd.pictures);

  final pageController = PageController();
  final currentSliderIndex = Rx(0);

  SingleAdDetailsController(this.dynamicAd);

  void removePicture() {
    if (pictures.length > 1) {
      pictures.removeAt(currentSliderIndex.value);
    }
  }
}
