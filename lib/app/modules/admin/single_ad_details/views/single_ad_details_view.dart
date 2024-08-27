import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/enums.dart';
import '../../../../core/helper/ad_pdf_viewer.dart';
import '../../../../core/widget/video_player_widget.dart';
import '../../../../data/model/dynamic/dynamic_day_model.dart';
import '../../../../data/model/dynamic/dynamic_prop_model.dart';
import '../../review_ads/controllers/review_ads_controller.dart';
import '../controllers/single_ad_details_controller.dart';

class SingleAdDetailsView extends GetView<SingleAdDetailsController> {
  const SingleAdDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Details'),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
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
                              controller.dynamicAd.isPremium
                                  ? Icons.star_rounded
                                  : Icons.star_border,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (controller.dynamicAd.isApproved)
                          MaterialButton(
                            onPressed: () {},
                            child: 'Delete'.text,
                            textColor: Colors.white,
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        if (!controller.dynamicAd.isApproved)
                          MaterialButton(
                            onPressed: () => Get.find<ReviewAdsController>()
                                .showDeclineAdDialog(
                                    controller.dynamicAd, true),
                            child: 'Decline'.text,
                            textColor: Colors.white,
                            color:  Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        if (!controller.dynamicAd.isApproved)
                          MaterialButton(
                            onPressed: () => Get.find<ReviewAdsController>()
                                .showApproveAdDialog(
                              controller.dynamicAd,
                              controller.pictures,
                              true,
                            ),
                            child: 'Approve'.text,
                            textColor: Colors.white,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                      ],
                    ),
                    if (controller.dynamicAd.user != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                controller.dynamicAd.user!.profilePicture,
                              ),
                            ),
                            controller.dynamicAd.user!.fullName.text.size(18),
                          ],
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
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
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    (controller.dynamicAd.mainCategoryName !=
                                                null
                                            ? controller
                                                .dynamicAd.mainCategoryName!
                                            : '')
                                        .text
                                        .semiBold
                                        .size(16)
                                        .color(Colors.red),
                                    const SizedBox(height: 5),
                                    (controller.dynamicAd.subCategoryName !=
                                                null
                                            ? controller
                                                .dynamicAd.subCategoryName!
                                            : '')
                                        .text
                                        .semiBold
                                        .size(16)
                                        .color(Get.theme.primaryColor),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            controller.dynamicAd.title.text.bold.size(22),
                          ],
                        ),
                      ),
                    ),
                    ...controller.dynamicAd.props.map((e) => _buildProp(e)),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin:
                          const EdgeInsets.only(bottom: 20, right: 5, left: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          'Description'
                              .text
                              .size(18)
                              .semiBold
                              .color(Get.theme.primaryColor),
                          const Spacer(),
                          Flexible(
                              flex: 5,
                              child: controller.dynamicAd.description.text),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
            child: propModel.nameEn.text
                .size(18)
                .semiBold
                .color(Get.theme.primaryColor),
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
            ? propModel.selections[int.parse(propModel.value)].name.text
            : propModel.type == DynamicAdInputType.dayPicker ||
                    propModel.type == DynamicAdInputType.checkBox
                ? Wrap(
                    spacing: 10,
                    children: propModel.values
                        .map(
                          (e) => DynamicDayModel(int.parse(e.toString()))
                              .name
                              .text,
                        )
                        .toList(),
                  )
                : propModel.type == DynamicAdInputType.videoPicker
                    ? VideoPlayWidget(url: propModel.value)
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
            children: controller.pictures
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
                controller.pictures.length,
                (i) => _buildPoints(i),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.red,
              ),
              onPressed: () => controller.removePicture()),
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
