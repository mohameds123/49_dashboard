import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/come_with_me_trip_model.dart';
import '../../come_with_me_trips/widget/come_with_widget.dart';
import '../controllers/review_come_with_me_trips_controller.dart';

class ReviewComeWithMeTripsView
    extends GetView<ReviewComeWithMeTripsController> {
  const ReviewComeWithMeTripsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Come With Me'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.ridesPagingController,
        builderDelegate: PagedChildBuilderDelegate<ComeWithMeTripModel>(
          itemBuilder: (context, item, index) => ComeWithMeWidget(
            comeWithMeTrip: item,
            onDeleteClick: () => controller.showDeleteRideConfirm(item),
            onApproveClick: () => controller.showApproveRideConfirm(item),
          ),
        ),
      ),
    );
  }
}
