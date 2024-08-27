import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/come_with_me_trip_model.dart';

class ComeWithMeTripsController extends GetxController {
  late final ridesPagingController =
      PagingController<int, ComeWithMeTripModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchRidesPage);

  Future<void> _fetchRidesPage(int pageKey) async {
    try {
      final result = await CustomDio(enableLog: true)
          .get('admin/get-come-with-me-trips?page=$pageKey');

      final newItemsResult = ((result.data as Map<String, dynamic>)['data']
              as List)
          .map((e) => ComeWithMeTripModel.fromMap(e as Map<String, dynamic>))
          .toList();

      final newItems = newItemsResult
          .where((e) => !ridesPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.length < 20;
      if (isLastPage) {
        ridesPagingController.appendLastPage(newItems);
      } else {
        ridesPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (e) {
      ridesPagingController.error = 'No Internet Connection'.tr;
    }
  }

  void showDeleteRideConfirm(ComeWithMeTripModel comeWithMeTrip) {
    Get.defaultDialog(
      title: 'Confirm!'.tr,
      titleStyle: const TextStyle(color: Colors.red),
      middleText: 'Are you sure you want to delete this Ride?'.tr,
      textConfirm: 'Yes'.tr,
      textCancel: 'No'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () => deleteRide(comeWithMeTrip),
    );
  }

  Future<void> deleteRide(ComeWithMeTripModel comeWithMeTrip) async {
    try {
      Get.back();
      await CustomDio().delete('admin/delete-come-with-me-trip/${comeWithMeTrip.id}');
      Get.defaultDialog(
        title: '',
        middleText: 'Ride Deleted Successfully'.tr,
        textCancel: 'Ok'.tr,
      );
      ridesPagingController.removeItem(comeWithMeTrip);
      Get.back();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }
}
