import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/main_category_model.dart';

class AdminMainCategoryController extends GetxController {
  final mainCategories = RxList<MainCategoryModel>();

  void getData() async {
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

  void pickCoverPicture(MainCategoryModel mainCategory) async {
    final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture != null) {
      mainCategory.coverPath = picture.path;
      mainCategories.refresh();
    }
  }

  void pickBannerPicture(MainCategoryModel mainCategory) async {
    final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture != null) {
      mainCategory.bannerPath = picture.path;
      mainCategories.refresh();
    }
  }

  void showEditNameArDialog(MainCategoryModel mainCategory) {
    String nameAr = mainCategory.nameAr;

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
                mainCategory.nameAr = nameAr;
                mainCategories.refresh();
              },
            )
          ],
        ),
      ),
    );
  }

  void showEditNameEnDialog(MainCategoryModel mainCategory) {
    String nameEn = mainCategory.nameEn;

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
                mainCategory.nameEn = nameEn;
                mainCategories.refresh();
              },
            )
          ],
        ),
      ),
    );
  }

  void saveCategory(MainCategoryModel mainCategory) async {
    try {
      CustomAlert.customLoadingDialog();

      if (mainCategory.bannerPath != null) {
        final path = await AppConstants.spaceBucket
            .uploadFile(mainCategory.bannerPath!, 'image/jpg', 'jpg');

        if (path != null) {
          mainCategory.banner = path;
          mainCategory.bannerPath = null;
        }
      }
      if (mainCategory.coverPath != null) {
        final path = await AppConstants.spaceBucket
            .uploadFile(mainCategory.coverPath!, 'image/jpg', 'jpg');

        if (path != null) {
          mainCategory.cover = path;
          mainCategory.coverPath = null;
        }
      }
      await CustomDio()
          .put('admin/main-categories', body: mainCategory.toMap());

      Get.back();
      CustomAlert.snackBar(msg: 'Success Main Category Edited.');
      getData();
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
