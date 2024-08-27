import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/post_feeling_model.dart';

class PostFeelingController extends GetxController {
  final feelings = RxList<PostFeelingModel>();

  final _defaultPictures = [
    ...List.generate(
        45,
        (index) =>
            'https://49-space.fra1.digitaloceanspaces.com/main/feelings/${index + 1}.svg')
  ];

  void getData() async {
    try {
      final result = await CustomDio().get('super-admin/post-feelings');

      feelings.value = (result.data['data'] as List)
          .map((e) => PostFeelingModel.fromMap(e))
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

  void showEditSheet(PostFeelingModel feeling) {
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
                  initValue: feeling.nameAr,
                  onChange: (v) => feeling.nameAr = v,
                ),
                SizedBox(height: 10),
                CustomTextFieldWithBackground(
                  label: 'Name En',
                  initValue: feeling.nameEn,
                  onChange: (v) => feeling.nameEn = v,
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
                    if (feeling.nameAr.isNotEmpty &&
                        feeling.nameEn.isNotEmpty) {
                      editFeeling(feeling);
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
        'super-admin/post-feelings',
        body: {
          'name_ar': nameAr,
          'name_en': nameEn,
          'picture':
              (pictureUrl ?? picture).replaceAll(AppConstants.imageBaseUrl, ''),
        },
      );
      feelings.add(PostFeelingModel.fromMap(result.data['data']));
      Get.back();
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void deleteFeeling(PostFeelingModel Feeling) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      await CustomDio().delete('super-admin/post-feelings/${Feeling.id}');

      feelings.remove(Feeling);
      Get.back();
      CustomAlert.snackBar(msg: 'Success Post Feeling Deleted.');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteFeelingDialog(PostFeelingModel Feeling) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this Feeling?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteFeeling(Feeling),
    );
  }

  void editFeeling(PostFeelingModel Feeling) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      final result = await CustomDio().put(
        'super-admin/post-feelings',
        body: Feeling.toMap(),
      );

      final index = feelings.indexOf(Feeling);
      if (index != -1) {
        feelings.remove(Feeling);
        feelings.insert(index, PostFeelingModel.fromMap(result.data['data']));
      }
      Get.back();
      CustomAlert.snackBar(msg: 'Success Post Feeling Deleted.');
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
