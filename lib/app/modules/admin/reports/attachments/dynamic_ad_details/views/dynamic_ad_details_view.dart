import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../../../../main.dart';
import '../../../../../../core/app_state.dart';
import '../../../../../../core/enums.dart';
import '../../../../../../core/widget/video_player_widget.dart';
import '../../../../../../data/model/dynamic/dynamic_prop_model.dart';
import '../controllers/dynamic_ad_details_controller.dart';
import '../widget/ad_pdf_viewer.dart';

class DynamicAdDetailsView extends GetView<DynamicAdDetailsController> {
  const DynamicAdDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
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
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Stack(
                    children: [
                      _buildSlider(),
                      Positioned(
                        top: 12,
                        right: 8,
                        child: Icon(
                          controller.dynamicAdModel.isPremium
                              ? Icons.star_rounded
                              : Icons.star_border,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.dynamicAdModel.isSubscription)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: 'User is Subscribed'.tr.text.color(Colors.red),
                    ),
                  ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.visibility, color: Colors.red),
                            const SizedBox(width: 6),
                            (controller.adViews.value?.toString() ?? '').text,
                            const SizedBox(
                              width: 10,
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 5),
                                (controller.dynamicAdModel.subCategoryName !=
                                            null
                                        ? controller
                                            .dynamicAdModel.subCategoryName!
                                        : '')
                                    .text
                                    .semiBold
                                    .size(16)
                                    .color(mainColor),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        controller.dynamicAdModel.title.text.bold.size(22),
                      ],
                    ),
                  ),
                ),
                ...controller.dynamicAdModel.props.map((e) => _buildProp(e)),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(bottom: 20, right: 5, left: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      'Description'.tr.text.size(18).semiBold.color(mainColor),
                      const Spacer(),
                      Flexible(
                        flex: 5,
                        child: controller.dynamicAdModel.description.text,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProp(DynamicPropModel propModel) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 20, right: 5, left: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(
              minWidth: 80,
            ),
            child: propModel.nameEn.text.size(18).semiBold.color(mainColor),
          ),
          const Spacer(),
          Flexible(flex: 5, child: _buildDynamicProp(propModel)),
        ],
      ),
    );
  }

  Widget _buildDynamicProp(DynamicPropModel propModel) {
    return propModel.type == DynamicAdInputType.textField ||
            propModel.type == DynamicAdInputType.datePicker
        ? propModel.value.text
        : propModel.type == DynamicAdInputType.dropDown
            ? (propModel.selections.length >= int.parse(propModel.value)
                    ? propModel.selections[int.parse(propModel.value)].name
                    : '')
                .text
            : propModel.type == DynamicAdInputType.dayPicker ||
                    propModel.type == DynamicAdInputType.checkBox
                ? Wrap(
                    spacing: 10,
                    children: propModel.values
                        .map(
                          (e) => days[int.parse(e.toString())].tr.text,
                        )
                        .toList(),
                  )
                : propModel.type == DynamicAdInputType.videoPicker
                    ? VideoPlayWidget(
                        url: propModel.value,
                      )
                    : propModel.type == DynamicAdInputType.pdfPicker
                        ? IconButton(
                            onPressed: () =>
                                Get.to(AdPdfViewer(pdfLink: propModel.value)),
                            icon: const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox();
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
            children: controller.dynamicAdModel.pictures
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
                controller.dynamicAdModel.pictures.length,
                (i) => _buildPoints(i),
              ),
            ),
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

const days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];
