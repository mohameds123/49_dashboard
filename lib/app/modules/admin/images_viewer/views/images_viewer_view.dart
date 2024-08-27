import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/images_viewer_controller.dart';

class ImagesViewerView extends GetView<ImagesViewerController> {
  const ImagesViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              "${controller.currentIndex.value + 1} / ${controller.images.length}"),
        ),
      ),
      body: PageView.builder(
        onPageChanged: (index) => controller.currentIndex.value = index,
        controller: controller.pageController,
        itemCount: controller.images.length,
        itemBuilder: (_, index) => _buildPageViewItem(
          controller.images[index],
        ),
      ),
    );
  }

  Widget _buildOneImage(String url) {
    return !url.startsWith('http')
        ? Image.file(
            File(url),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
            gaplessPlayback: true,
          )
        : CachedNetworkImage(
            imageUrl: url,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          );
  }

  Widget _buildPageViewItem(String url) {
    return controller.images.indexOf(url) == controller.initIndex
        ? Hero(
            tag: url,
            child: _buildOneImage(url),
          )
        : _buildOneImage(url);
  }
}
