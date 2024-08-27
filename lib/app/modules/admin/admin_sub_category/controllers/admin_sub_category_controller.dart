import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/main_category_model.dart';
import '../../../../data/model/sub_category_model.dart';

class AdminSubCategoryController extends GetxController {
  final mainCategories = RxList<MainCategoryModel>();
  final subCategories = RxList<SubCategoryModel>();

  String? currentMainCategory;

  void getMainCategories() async {
    try {
      final result = await CustomDio().get('admin/main-categories');

      mainCategories.value = (result.data['data'] as List)
          .map((e) => MainCategoryModel.fromMap(e))
          .toList();
      mainCategories.sort((a, b) => a.index.compareTo(b.index));
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void onMainCategoryChanged(String? id) async {
    try {
      final result = await CustomDio().get('admin/sub-categories/$id');

      subCategories.value = (result.data['data'] as List)
          .map((e) => SubCategoryModel.fromMap(e))
          .toList();

      subCategories.sort((a, b) => a.index.compareTo(b.index));
      currentMainCategory = id;
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void saveCategory(SubCategoryModel subCategory) async {
    try {
      CustomAlert.customLoadingDialog();

      if (subCategory.picturePath != null) {
        final path = await AppConstants.spaceBucket
            .uploadFile(subCategory.picturePath!, 'image/jpg', 'jpg');

        if (path != null) {
          subCategory.picture = path;
          subCategory.picturePath = null;
        }
      }
      await CustomDio()
          .put('admin/sub-categories', body: subCategory.toBriefMap());

      Get.back();
      CustomAlert.snackBar(msg: 'Success Main Category Edited.');
      onMainCategoryChanged(subCategory.parent);
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void pickPicture(SubCategoryModel subCategory) async {
    final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture != null) {
      subCategory.picturePath = picture.path;
      subCategories.refresh();
    }
  }

  void showEditNameArDialog(SubCategoryModel subCategory) {
    String nameAr = subCategory.nameAr;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Edit Category Name Ar'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Name Ar',
              initValue: nameAr,
              onChange: (v) => nameAr = v,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child: 'Edit'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () {
                Get.back();
                subCategory.nameAr = nameAr;
                subCategories.refresh();
              },
            )
          ],
        ),
      ),
    );
  }

  void showEditNameEnDialog(SubCategoryModel subCategory) {
    String nameEn = subCategory.nameEn;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Edit Category Name En'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Name En',
              initValue: nameEn,
              onChange: (v) => nameEn = v,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child: 'Edit'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () {
                Get.back();
                subCategory.nameEn = nameEn;
                subCategories.refresh();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    getMainCategories();
    super.onInit();
  }
}
