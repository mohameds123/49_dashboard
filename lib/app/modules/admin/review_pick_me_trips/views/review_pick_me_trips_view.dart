import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/pick_me_trip_model.dart';
import '../../pick_me_trips/widget/pick_me_widget.dart';
import '../controllers/review_pick_me_trips_controller.dart';

class ReviewPickMeTripsView extends GetView<ReviewPickMeTripsController> {
  const ReviewPickMeTripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Pick Me'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.ridesPagingController,
        builderDelegate: PagedChildBuilderDelegate<PickMeTripModel>(
          itemBuilder: (context, item, index) => PickMeWidget(
            pickMeTrip: item,
            onDeleteClick: () => controller.showDeleteRideConfirm(item),
            onApproveClick: () => controller.showApproveRideConfirm(item),
          ),
        ),
      ),
    );
  }
}
