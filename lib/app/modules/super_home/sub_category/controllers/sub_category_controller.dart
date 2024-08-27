import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/sub_category_model.dart';

class SubCategoryController extends GetxController {
  final String mainCategory;

  final subCategories = RxList<SubCategoryModel>();

  SubCategoryController(this.mainCategory);

  void getData() async {
    try {
      final result =
          await CustomDio().get('super-admin/sub-categories/$mainCategory');

      subCategories.value = (result.data['data'] as List)
          .map((e) => SubCategoryModel.fromMap(e))
          .toList();

      subCategories.sort((a, b) => a.index.compareTo(b.index));
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void updateSubCategory(SubCategoryModel subCategory) async {
    try {
      CustomAlert.customLoadingDialog();

      await CustomDio().put(
        'super-admin/sub-categories/${subCategory.id}',
        body: subCategory.toMap(),
      );
      if (subCategory.newIndex != null &&
          subCategory.newIndex != subCategory.index) {
        int index = subCategory.newIndex!;

        if (index >= subCategories.length) {
          index = subCategories.length - 1;
        }
        subCategories.remove(subCategory);
        subCategories.insert(index, subCategory);
        for (int i = 0; i < subCategories.length; i++) {
          subCategories[i].index = i;
        }
        subCategories.sort((a, b) => a.index.compareTo(b.index));
        subCategories.forEach((e) {
          print('${e.nameAr} => ${e.index}');
        });

        await CustomDio().put(
          'super-admin/sub-categories-indexes',
          body: {
            'ids': subCategories.map((e) => e.id).toList(),
            'indexes': subCategories.map((e) => e.index).toList(),
          },
        );
        getData();
      }
      Get.back();
      CustomAlert.snackBar(msg: 'Updated');
    } catch (e) {
      print(e);
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteConfirm(String id) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this sub category?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteSubCategory(id),
    );
  }

  void deleteSubCategory(String id) async {
    Get.back();
    try {
      CustomAlert.customLoadingDialog();

      await CustomDio().delete(
        'super-admin/sub-categories/$id',
      );
      Get.back();
      CustomAlert.snackBar(msg: 'Deleted');
      subCategories.removeWhere((e) => e.id == id);
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
