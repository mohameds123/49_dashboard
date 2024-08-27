import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/come_with_me_trip_model.dart';
import '../controllers/come_with_me_trips_controller.dart';
import '../widget/come_with_widget.dart';

class ComeWithMeTripsView extends GetView<ComeWithMeTripsController> {
  const ComeWithMeTripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Come With Me Trips'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.ridesPagingController,
        builderDelegate: PagedChildBuilderDelegate<ComeWithMeTripModel>(
          itemBuilder: (context, item, index) => ComeWithMeWidget(
            comeWithMeTrip: item,
            onDeleteClick: () => controller.showDeleteRideConfirm(item),
          ),
        ),
      ),
    );
  }
}
