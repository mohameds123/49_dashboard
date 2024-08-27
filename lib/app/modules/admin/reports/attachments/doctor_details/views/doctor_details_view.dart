import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../../../../main.dart';
import '../../../../../../core/app_state.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../../../data/model/rating_model.dart';
import '../../dynamic_ad_details/views/dynamic_ad_details_view.dart';
import '../controllers/doctor_details_controller.dart';

class DoctorDetailsView extends GetView<DoctorDetailsController> {
  const DoctorDetailsView({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoWidget(),
                const SizedBox(height: 20),
                if (controller.doctor.isSubscription)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: 'User is Subscribed'.tr.text.color(Colors.red),
                    ),
                  ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: mainColor,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        '${controller.doctor.waitingTime} ${'Min'.tr}'
                            .text
                            .size(20),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.wallet_rounded,
                          color: mainColor,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        '${controller.doctor.examinationPrice}'.text.size(20),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: mainColor,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    controller.doctor.location.text.size(20),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 'Days'.tr.text.size(20).color(Colors.red),
                ),
                Wrap(
                  spacing: 5,
                  alignment: WrapAlignment.end,
                  children: controller.doctor.availableDays
                      .map(
                        (e) => Chip(
                          backgroundColor: mainColor,
                          padding: EdgeInsets.zero,
                          label: Container(
                            constraints: const BoxConstraints(maxWidth: 70),
                            child: Center(
                              child: Text(
                                days[e].tr,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Time'.tr.text.size(20).color(Colors.red),
                      '${'from'.tr} ${controller.doctor.workFrom > 12 ? '${controller.doctor.workFrom - 12} ${'PM'.tr}' : '${controller.doctor.workFrom} ${'AM'.tr}'} ${'to'.tr} ${controller.doctor.workTo > 12 ? '${controller.doctor.workTo - 12} ${'PM'.tr}' : '${controller.doctor.workTo} ${'AM'.tr}'}'
                          .text
                          .size(16)
                    ],
                  ),
                ),
                const Divider(),
                PagedListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  pagingController: controller.ratingsPagingController,
                  builderDelegate: PagedChildBuilderDelegate<RatingModel>(
                    itemBuilder: (context, item, index) => _buildRatingWidget(
                      item,
                    ),
                  ),
                  showNoItemsMessage: false,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: mainColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 66,
              child: CircleAvatar(
                radius: 65,
                backgroundImage: CachedNetworkImageProvider(
                  controller.doctor.picture,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SizedBox(
                width: Get.width * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: "${'Dr.'.tr} ${controller.doctor.name}"
                              .text
                              .size(20)
                              .semiBold
                              .maxLine(2)
                              .overflowEllipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    controller.doctor.specialty.text,
                    RatingStars(
                      value: controller.doctor.rating,
                      starSize: 15,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingWidget(RatingModel rating) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: mainColor,
          backgroundImage: CachedNetworkImageProvider(
            rating.user?.profilePicture ?? '',
          ),
        ),
        title: (rating.user?.firstName ?? '').text,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Health'.tr.text,
                RatingStars(
                  value: rating.fieldOne,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Service'.tr.text,
                RatingStars(
                  value: rating.fieldTwo,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Doctor'.tr.text,
                RatingStars(
                  value: rating.fieldThree,
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Opinion'.tr.text.semiBold,
                      const SizedBox(
                        height: 10,
                      ),
                      rating.comment.text,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            rating.timeAgo.text,
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
