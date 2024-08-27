import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textless/textless.dart';

import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/gift_model.dart';

class GiftsController extends GetxController {
  final gifts = RxList<GiftModel>();

  final _defaultPictures = [
    'https://49-space.fra1.digitaloceanspaces.com/main/gifts/lion.png',
    'https://49-space.fra1.digitaloceanspaces.com/main/gifts/money.png',
    'https://49-space.fra1.digitaloceanspaces.com/main/gifts/giftbox.png',
    'https://49-space.fra1.digitaloceanspaces.com/main/gifts/flower.png',
    'https://49-space.fra1.digitaloceanspaces.com/main/gifts/gift.png',
    'https://49-space.fra1.digitaloceanspaces.com/main/gifts/star.png',
    'https://49-space.fra1.digitaloceanspaces.com/main/gifts/butterfly.png',
  ];

  void getData() async {
    try {
      final result = await CustomDio().get('super-admin/gifts');

      gifts.value = (result.data['data'] as List)
          .map((e) => GiftModel.fromMap(e))
          .toList();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void showAddSheet() {
    String nameAr = '';
    String nameEn = '';
    String picture = '';
    double value = 0;

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
                CustomTextFieldWithBackground(
                  label: 'Value',
                  textInputType: TextInputType.number,
                  onChange: (v) => value = double.tryParse(v) ?? value,
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
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                _defaultPictures[index - 1],
                                            width: 70,
                                            height: 50,
                                            color: value ==
                                                    _defaultPictures[index - 1]
                                                ? Get.theme.primaryColor
                                                : null,
                                          )
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
                    if (nameAr.isNotEmpty &&
                        nameEn.isNotEmpty &&
                        picture.isNotEmpty &&
                        value > 0) {
                      addGift(nameAr, nameEn, picture, value);
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

  void showEditSheet(GiftModel gift) {
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
                  initValue: gift.nameAr,
                  onChange: (v) => gift.nameAr = v,
                ),
                SizedBox(height: 10),
                CustomTextFieldWithBackground(
                  label: 'Name En',
                  initValue: gift.nameEn,
                  onChange: (v) => gift.nameEn = v,
                ),
                SizedBox(height: 10),
                CustomTextFieldWithBackground(
                  label: 'Value',
                  initValue: gift.value.toString(),
                  textInputType: TextInputType.number,
                  onChange: (v) =>
                      gift.value = double.tryParse(v) ?? gift.value,
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
                    if (gift.nameAr.isNotEmpty &&
                        gift.nameEn.isNotEmpty &&
                        gift.value > 0) {
                      editGift(gift);
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

  void addGift(
      String nameAr, String nameEn, String picture, double value) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();

      String? pictureUrl;

      if (!picture.startsWith('http')) {
        pictureUrl = await AppConstants.spaceBucket
            .uploadFile(picture, 'image/jpg', 'jpg');
      }

      final result = await CustomDio().post(
        'super-admin/gifts',
        body: {
          'name_ar': nameAr,
          'name_en': nameEn,
          'value': value,
          'picture':
              (pictureUrl ?? picture).replaceAll(AppConstants.imageBaseUrl, ''),
        },
      );

      gifts.add(GiftModel.fromMap(result.data['data']));
      Get.back();
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void editGift(GiftModel gift) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      await CustomDio().put('super-admin/gifts', body: gift.toMap());
      Get.back();
      CustomAlert.snackBar(msg: 'Updated Successfully');
      getData();
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void deleteGift(GiftModel gift) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      await CustomDio().delete('super-admin/gifts/${gift.id}');
      gifts.remove(gift);
      Get.back();
      CustomAlert.snackBar(msg: 'Deleted Successfully');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteConfirmDialog(GiftModel gift) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this Gift?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteGift(gift),
    );
  }
}
