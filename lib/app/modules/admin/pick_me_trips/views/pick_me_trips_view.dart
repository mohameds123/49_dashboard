import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/pick_me_trip_model.dart';
import '../controllers/pick_me_trips_controller.dart';
import '../widget/pick_me_widget.dart';

class PickMeTripsView extends GetView<PickMeTripsController> {
  const PickMeTripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Me Trips'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.ridesPagingController,
        builderDelegate: PagedChildBuilderDelegate<PickMeTripModel>(
          itemBuilder: (context, item, index) => PickMeWidget(
            pickMeTrip: item,
            onDeleteClick: () => controller.showDeleteRideConfirm(item),
          ),
        ),
      ),
    );
  }
}
