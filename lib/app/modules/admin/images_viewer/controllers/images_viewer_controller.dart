import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesViewerController extends GetxController {
  final List<String> images;
  final int initIndex;

  late final currentIndex = Rx(initIndex);
  late final pageController = PageController(initialPage: initIndex);

  ImagesViewerController(this.images, this.initIndex);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
