import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/post_activity_model.dart';

class PostActivityController extends GetxController {
  final activities = RxList<PostActivityModel>();

  final _defaultPictures = [
    ...List.generate(
        72,
        (index) =>
            'https://49-space.fra1.digitaloceanspaces.com/main/activities/${index + 1}.png')
  ];

  void getData() async {
    try {
      final result = await CustomDio().get('super-admin/post-activities');

      activities.value = (result.data['data'] as List)
          .map((e) => PostActivityModel.fromMap(e))
          .toList();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showAddSheet() {
    String nameAr = '';
    String nameEn = '';
    String picture = '';

    Get.bottomSheet(
      Material(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                CustomTextFieldWithBackground(
                  label: 'Name Ar',
                  onChange: (v) => nameAr = v,
                ),
                SizedBox(height: 10),
                CustomTextFieldWithBackground(
                  label: 'Name En',
                  onChange: (v) => nameEn = v,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  width: Get.width,
                  child: ValueBuilder<String?>(
                    onUpdate: (v) => picture = v!,
                    builder: (value, update) => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _defaultPictures.length + 1,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          child: index == 0
                              ? IconButton(
                                  onPressed: () async {
                                    final image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      _defaultPictures.add(image.path);
                                      update('');
                                    }
                                  },
                                  icon: Icon(Icons.add),
                                )
                              : InkWell(
                                  onTap: () =>
                                      update(_defaultPictures[index - 1]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: _defaultPictures[index - 1]
                                            .startsWith('http')
                                        ? (_defaultPictures[index - 1]
                                                .endsWith('.svg')
                                            ? SvgPicture.network(
                                                _defaultPictures[index - 1],
                                                width: 70,
                                                height: 50,
                                                color: value ==
                                                        _defaultPictures[
                                                            index - 1]
                                                    ? Get.theme.primaryColor
                                                    : null,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    _defaultPictures[index - 1],
                                                width: 70,
                                                height: 50,
                                                color: value ==
                                                        _defaultPictures[
                                                            index - 1]
                                                    ? Get.theme.primaryColor
                                                    : null,
                                              ))
                                        : Image.file(
                                            File(_defaultPictures[index - 1]),
                                            width: 70,
                                            height: 50,
                                            color: value ==
                                                    _defaultPictures[index - 1]
                                                ? Get.theme.primaryColor
                                                : null,
                                          ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  child: 'Add'.text,
                  color: Colors.green,
                  disabledColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: Get.width,
                  textColor: Colors.white,
                  onPressed: () {
                    if (nameAr.isNotEmpty && nameEn.isNotEmpty) {
                      addFeeling(nameAr, nameEn, picture);
                    } else {
                      CustomAlert.showError('Please Fill All Fields');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showEditSheet(PostActivityModel activity) {
    Get.bottomSheet(
      Material(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                CustomTextFieldWithBackground(
                  label: 'Name Ar',
                  initValue: activity.nameAr,
                  onChange: (v) => activity.nameAr = v,
                ),
                SizedBox(height: 10),
                CustomTextFieldWithBackground(
                  label: 'Name En',
                  initValue: activity.nameEn,
                  onChange: (v) => activity.nameEn = v,
                ),
                SizedBox(height: 10),
                MaterialButton(
                  child: 'Edit'.text,
                  color: Colors.green,
                  disabledColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: Get.width,
                  textColor: Colors.white,
                  onPressed: () {
                    if (activity.nameAr.isNotEmpty &&
                        activity.nameEn.isNotEmpty) {
                      editActivity(activity);
                    } else {
                      CustomAlert.showError('Please Fill All Fields');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addFeeling(String nameAr, String nameEn, String picture) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();

      String? pictureUrl;
      if (!picture.startsWith('http')) {
        pictureUrl = await AppConstants.spaceBucket
            .uploadFile(picture, 'image/jpg', 'jpg');
      }

      final result = await CustomDio().post(
        'super-admin/post-activities',
        body: {
          'name_ar': nameAr,
          'name_en': nameEn,
          'picture':
              (pictureUrl ?? picture).replaceAll(AppConstants.imageBaseUrl, ''),
        },
      );
      activities.add(PostActivityModel.fromMap(result.data['data']));
      Get.back();
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void deleteActivity(PostActivityModel activity) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      await CustomDio().delete('super-admin/post-activities/${activity.id}');

      activities.remove(activity);
      Get.back();
      CustomAlert.snackBar(msg: 'Success Post Activity Deleted.');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteActivityDialog(PostActivityModel activity) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this Activity?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteActivity(activity),
    );
  }

  void showEditActivityDialog(PostActivityModel activity) {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Edit Post Activity'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Name Ar',
              initValue: activity.nameAr,
              onChange: (v) => activity.nameAr = v,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Name En',
              initValue: activity.nameEn,
              onChange: (v) => activity.nameEn = v,
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
              onPressed: () => editActivity(activity),
            )
          ],
        ),
      ),
    );
  }

  void editActivity(PostActivityModel activity) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      final result = await CustomDio().put(
        'super-admin/post-activities',
        body: activity.toMap(),
      );

      final index = activities.indexOf(activity);
      if (index != -1) {
        activities.remove(activity);
        activities.insert(
            index, PostActivityModel.fromMap(result.data['data']));
      }
      Get.back();
      CustomAlert.snackBar(msg: 'Success Post Activity Deleted.');
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
