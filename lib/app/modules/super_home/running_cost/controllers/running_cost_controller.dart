import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/running_cost_model.dart';

class RunningCostController extends GetxController {
  late final costsPagingController =
      PagingController<int, RunningCostModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchCostsPage);

  final total = Rx(0.0);
  int _currentType = -1;

  Future<void> _fetchCostsPage(int pageKey) async {
    try {
      if (_currentType < 0) return costsPagingController.appendLastPage([]);

      final result = await CustomDio()
          .get('super-admin/running-cost/$_currentType?page=$pageKey');

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => RunningCostModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !costsPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        costsPagingController.appendLastPage(newItems);
      } else {
        costsPagingController.appendPage(newItems, pageKey + 1);
      }
      total.value = costsPagingController.itemList.fold<double>(
          0, (previousValue, element) => element.cost + previousValue);
    } catch (error) {
      costsPagingController.error = error;
    }
  }


  void showAddDialog() {
    if (_currentType != 0) {
      String note = '';
      double cost = 0;
      Get.dialog(
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFieldWithBackground(
                label: 'Cost',
                textInputType: TextInputType.number,
                onChange: (v) => cost = double.tryParse(v) ?? 0,
              ),
              SizedBox(height: 10),
              CustomTextFieldWithBackground(
                label: 'Note',
                onChange: (v) => note = v,
              ),
              SizedBox(height: 10),
              MaterialButton(
                child: 'Add'.text,
                color: Get.theme.primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: double.infinity,
                onPressed: () => addCost(note, cost),
              )
            ],
          ),
        ),
      );
    }
  }

  void onTypeChanged(int? type) async {
    if (type != _currentType) {
      _currentType = type!;
      costsPagingController.refresh();
    }
  }

  void addCost(String note, double cost) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();

      final result = await CustomDio().post(
        'super-admin/running-cost',
        body: {
          'type': _currentType,
          'cost': cost,
          'note': note,
        },
      );
      Get.back();
      costsPagingController
          .addItem(RunningCostModel.fromMap(result.data['data']));
      CustomAlert.snackBar(msg: 'Added Successfully');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteConfirmDialog(RunningCostModel runningCost) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this cost?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteCost(runningCost),
    );
  }

  void deleteCost(RunningCostModel runningCost) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      await CustomDio().delete('super-admin/running-cost/${runningCost.id}');
      costsPagingController.removeItem(runningCost);
      Get.back();
      CustomAlert.snackBar(msg: 'Deleted Successfully');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }
}
