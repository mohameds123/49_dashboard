import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textless/textless.dart';

import '../../../../../../core/app_state.dart';
import '../../../../../../data/model/food_item_model.dart';
import '../controllers/request_food_controller.dart';

class RequestFoodView extends GetView<RequestFoodController> {
  final String restaurantId;

  const RequestFoodView({
    super.key,
    required this.restaurantId,
  });

  @override
  String get tag => restaurantId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        final state = controller.state.value;
        if (state is CustomLoadingState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is CustomErrorState) {
          return Center(
            child: state.err.text.black.color(Colors.red),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: controller.restaurant.name.text.bold.size(20),
              ),
              _buildSlider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    '${controller.restaurant.rating} (${NumberFormat.compact().format(controller.restaurant.total)})'
                        .text,
                    const Icon(
                      Icons.timer_outlined,
                      size: 16,
                    ),
                    (controller.restaurant.isOpened ? 'Open'.tr : 'Closed'.tr)
                        .text
                        .color(
                          controller.restaurant.isOpened
                              ? Colors.green
                              : Colors.red,
                        )
                        .size(12),
                    const Spacer(),
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                    ),
                    controller.restaurant.location.text
                  ],
                ),
              ),
              if (controller.restaurant.isSubscription)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: 'User is Subscribed'.tr.text.color(Colors.red),
                  ),
                ),
              Obx(
                () => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.foodItems.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) =>
                      _buildFoodItem(controller.foodItems[index]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFoodItem(FoodItemModel foodItem) {
    return Obx(
      () => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: foodItem.picture != null
                      ? foodItem.picture!
                      : controller.restaurant.pictures.first,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    foodItem.name.text.bold.size(16),
                    foodItem.desc.text.size(16),
                    const SizedBox(
                      height: 20,
                    ),
                    foodItem.price.round().toString().text.size(16),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Stack(
      children: [
        SizedBox(
          width: Get.width,
          height: 250,
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (v) => controller.currentSliderIndex.value = v,
            children: controller.restaurant.pictures
                .map(
                  (value) => CachedNetworkImage(
                    imageUrl: value,
                    width: Get.width,
                    fit: BoxFit.fill,
                  ),
                )
                .toList(),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                controller.restaurant.pictures.length,
                (i) => _buildPoints(i),
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Icon(
            controller.restaurant.isPremium
                ? Icons.star_rounded
                : Icons.star_border,
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }

  Widget _buildPoints(int index) {
    return GestureDetector(
      onTap: () => controller.pageController.animateToPage(
        index,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 500),
      ),
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: index == controller.currentSliderIndex.value
                ? Get.theme.primaryColor
                : Colors.grey.withOpacity(.7),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
