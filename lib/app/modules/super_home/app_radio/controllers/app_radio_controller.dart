import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textless/textless.dart';
import '../../../../core/constants.dart';
import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/enums.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paging_controller.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/app_radio_model.dart';

class AppRadioController extends GetxController {
  late final categoryOnePagingController =
      PagingController<int, AppRadioModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchCategoryOnePage);

  late final categoryTwoPagingController =
      PagingController<int, AppRadioModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchCategoryTwoPage);

  late final categoryThreePagingController =
      PagingController<int, AppRadioModel>(firstPageKey: 1)
        ..addPageRequestListener(_fetchCategoryThreePage);

  Future<void> _fetchCategoryOnePage(int pageKey) async {
    try {
      final result =
          await CustomDio(enableLog: true).get('super-admin/app-radio', query: {
        'page': pageKey,
        'category': 1,
      });

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => AppRadioModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !categoryOnePagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        categoryOnePagingController.appendLastPage(newItems);
      } else {
        categoryOnePagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      categoryOnePagingController.error = error;
    }
  }

  Future<void> _fetchCategoryTwoPage(int pageKey) async {
    try {
      final result =
          await CustomDio(enableLog: true).get('super-admin/app-radio', query: {
        'page': pageKey,
        'category': 2,
      });

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => AppRadioModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !categoryTwoPagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        categoryTwoPagingController.appendLastPage(newItems);
      } else {
        categoryTwoPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      categoryTwoPagingController.error = error;
    }
  }

  Future<void> _fetchCategoryThreePage(int pageKey) async {
    try {
      final result =
          await CustomDio(enableLog: true).get('super-admin/app-radio', query: {
        'page': pageKey,
        'category': 3,
      });

      final newItemsResult =
          ((result.data as Map<String, dynamic>)['data'] as List)
              .map((e) => AppRadioModel.fromMap(e as Map<String, dynamic>))
              .toList();

      final newItems = newItemsResult
          .where((e) => !categoryThreePagingController.itemList.contains(e))
          .toList();

      final isLastPage = newItemsResult.isEmpty;
      if (isLastPage) {
        categoryThreePagingController.appendLastPage(newItems);
      } else {
        categoryThreePagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      categoryThreePagingController.error = error;
    }
  }

  void showAddSheet() {
    AppRadioTypes? type;
    String text = '';
    String? picture;
    String? video;
    String? voice;
    String? userId;
    int? days;
    bool isActive = false;
    AppRadioCategories? category;

    Get.bottomSheet(
      Material(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: ValueBuilder<AppRadioTypes?>(
              onUpdate: (v) => type = v,
              builder: (value, update) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  ValueBuilder<AppRadioCategories?>(
                    onUpdate: (v) => category = v,
                    builder: (value, update) => DropdownButton(
                        hint: 'Category'.text,
                        isExpanded: true,
                        value: value,
                        items: AppRadioCategories.values
                            .map(
                              (e) => DropdownMenuItem(
                                  value: e,
                                  child: e.name
                                      .replaceAll('_', ' ')
                                      .capitalize!
                                      .text),
                            )
                            .toList(),
                        onChanged: update),
                  ),
                  SizedBox(height: 20),
                  DropdownButton(
                      hint: 'Type'.text,
                      isExpanded: true,
                      value: value,
                      items: AppRadioTypes.values
                          .map(
                            (e) => DropdownMenuItem(
                                value: e, child: e.name.capitalizeFirst!.text),
                          )
                          .toList(),
                      onChanged: update),
                  SizedBox(height: 20),
                  CustomTextFieldWithBackground(
                    label: 'Text',
                    onChange: (v) => text = v,
                    textInputType: TextInputType.multiline,
                    maxLines: 5,
                  ),
                  SizedBox(height: 10),
                  CustomTextFieldWithBackground(
                    label: 'User ID',
                    onChange: (v) => userId = v,
                    textInputType: TextInputType.text,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWithBackground(
                          label: 'Days',
                          onChange: (v) => days = int.tryParse(v),
                          textInputType: TextInputType.number,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: Center(
                          child: ValueBuilder<bool?>(
                            onUpdate: (v) => isActive = v!,
                            initialValue: isActive,
                            builder: (value, update) => Switch(
                              value: value!,
                              onChanged: update,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: picture != null
                              ? Image.file(
                                  File(picture!),
                                  width: 100,
                                  fit: BoxFit.fill,
                                  height: 100,
                                )
                              : Icon(Icons.image, size: 50),
                        ),
                        onTap: () async {
                          if (type != null) {
                            final result = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (result != null) {
                              picture = result.path;
                              update(AppRadioTypes.values[value!.index]);
                            }
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      if (type == AppRadioTypes.video)
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Icon(Icons.video_collection,
                                size: 50,
                                color: video != null ? Colors.green : null),
                          ),
                          onTap: () async {
                            if (type != null) {
                              final result = await ImagePicker()
                                  .pickVideo(source: ImageSource.gallery);
                              if (result != null) {
                                video = result.path;
                                update(AppRadioTypes.values[value!.index]);
                              }
                            }
                          },
                        ),
                      if (type == AppRadioTypes.voice)
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Icon(Icons.settings_voice,
                                size: 50,
                                color: video != null ? Colors.green : null),
                          ),
                          onTap: () async {
                            if (type != null) {
                              final result = await FilePicker.platform
                                  .pickFiles(
                                      allowMultiple: false,
                                      type: FileType.audio);
                              if (result != null && result.paths.isNotEmpty) {
                                voice = result.paths.first!;
                                update(AppRadioTypes.values[value!.index]);
                              }
                            }
                          },
                        ),
                    ],
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
                      if (category == null)
                        return CustomAlert.showError(
                            'Select The Category First');
                      else if (type == null)
                        return CustomAlert.showError('Select The Type First');
                      else if (picture == null)
                        return CustomAlert.showError(
                            'Select The Picture First');
                      if (type == AppRadioTypes.video && video == null) {
                        return CustomAlert.showError('Select The Video first');
                      }
                      if (type == AppRadioTypes.voice && voice == null) {
                        return CustomAlert.showError('Select The Voice first');
                      }
                      if (type == AppRadioTypes.text && text.isEmpty) {
                        return CustomAlert.showError('Write text first');
                      }
                      if (days == null || days == 0) {
                        return CustomAlert.showError('Write Days First');
                      }
                      addItem(
                        type!,
                        category!,
                        userId: userId,
                        text: text,
                        picture: picture,
                        video: video,
                        voice: voice,
                        days: days!,
                        isActive: isActive,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showEditSheet(AppRadioModel appRadio) {
    Get.bottomSheet(
      Material(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: ValueBuilder<AppRadioTypes?>(
              onUpdate: (v) => appRadio.type = v!,
              initialValue: appRadio.type,
              builder: (value, update) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  ValueBuilder<AppRadioCategories?>(
                    onUpdate: (v) => appRadio.category = v!,
                    initialValue: appRadio.category,
                    builder: (value, update) => DropdownButton(
                        hint: 'Category'.text,
                        isExpanded: true,
                        value: value,
                        items: AppRadioCategories.values
                            .map(
                              (e) => DropdownMenuItem(
                                  value: e,
                                  child: e.name
                                      .replaceAll('_', ' ')
                                      .capitalize!
                                      .text),
                            )
                            .toList(),
                        onChanged: update),
                  ),
                  SizedBox(height: 20),
                  DropdownButton(
                      hint: 'Type'.text,
                      isExpanded: true,
                      value: value,
                      items: AppRadioTypes.values
                          .map(
                            (e) => DropdownMenuItem(
                                value: e, child: e.name.capitalizeFirst!.text),
                          )
                          .toList(),
                      onChanged: update),
                  SizedBox(height: 20),
                  CustomTextFieldWithBackground(
                    label: 'Text',
                    initValue: appRadio.text,
                    onChange: (v) => appRadio.text = v,
                    textInputType: TextInputType.multiline,
                    maxLines: 5,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldWithBackground(
                          label: 'Days',
                          initValue: appRadio.days.toString(),
                          onChange: (v) =>
                              appRadio.days = int.tryParse(v) ?? appRadio.days,
                          textInputType: TextInputType.number,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: Center(
                          child: ValueBuilder<bool?>(
                            onUpdate: (v) => appRadio.isActive = v!,
                            initialValue: appRadio.isActive,
                            builder: (value, update) => Switch(
                              value: value!,
                              onChanged: update,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: appRadio.picture != null
                              ? (appRadio.picture!.startsWith('http')
                                  ? CachedNetworkImage(
                                      imageUrl: appRadio.picture!,
                                      width: 100,
                                      fit: BoxFit.fill,
                                      height: 100,
                                    )
                                  : Image.file(
                                      File(appRadio.picture!),
                                      width: 100,
                                      fit: BoxFit.fill,
                                      height: 100,
                                    ))
                              : Icon(Icons.image, size: 50),
                        ),
                        onTap: () async {
                          final result = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (result != null) {
                            appRadio.picture = result.path;
                            update(AppRadioTypes.values[value!.index]);
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      if (appRadio.type == AppRadioTypes.video)
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Icon(Icons.video_collection,
                                size: 50,
                                color: appRadio.video != null
                                    ? Colors.green
                                    : null),
                          ),
                          onTap: () async {
                            final result = await ImagePicker()
                                .pickVideo(source: ImageSource.gallery);
                            if (result != null) {
                              appRadio.video = result.path;
                              update(AppRadioTypes.values[value!.index]);
                            }
                          },
                        ),
                      if (appRadio.type == AppRadioTypes.voice)
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Icon(Icons.settings_voice,
                                size: 50,
                                color: appRadio.video != null
                                    ? Colors.green
                                    : null),
                          ),
                          onTap: () async {
                            final result = await FilePicker.platform.pickFiles(
                                allowMultiple: false, type: FileType.audio);
                            if (result != null && result.paths.isNotEmpty) {
                              appRadio.voice = result.paths.first!;
                              update(AppRadioTypes.values[value!.index]);
                            }
                          },
                        ),
                    ],
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
                      if (appRadio.picture == null)
                        return CustomAlert.showError(
                            'Select The Picture First');
                      if (appRadio.type == AppRadioTypes.video &&
                          appRadio.video == null) {
                        return CustomAlert.showError('Select The Video first');
                      }
                      if (appRadio.type == AppRadioTypes.voice &&
                          appRadio.voice == null) {
                        return CustomAlert.showError('Select The Voice first');
                      }
                      if (appRadio.type == AppRadioTypes.text &&
                          appRadio.text!.isEmpty) {
                        return CustomAlert.showError('Write text first');
                      }
                      if (appRadio.days == 0) {
                        return CustomAlert.showError('Write Days First');
                      }
                      editItem(appRadio);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addItem(
    AppRadioTypes type,
    AppRadioCategories category, {
    String? text,
    String? picture,
    String? video,
    String? voice,
    String? userId,
    required bool isActive,
    required int days,
  }) async {
    String? picturePath;
    String? videoPath;
    String? voicePath;

    try {
      Get.back();
      CustomAlert.customLoadingDialog();

      if (picture != null) {
        picturePath = await AppConstants.spaceBucket
            .uploadFile(picture, 'image/jpg', 'jpg');
      }
      if (video != null) {
        videoPath = await AppConstants.spaceBucket
            .uploadFile(video, 'video/mp4', 'mp4');
      }
      if (voice != null) {
        voicePath = await AppConstants.spaceBucket
            .uploadFile(voice, 'audio/mp3', 'mp3');
      }
      final result = await CustomDio(enableLog: true).post(
        'super-admin/app-radio',
        body: {
          'type': type.index + 1,
          'text': text,
          'user_id': userId,
          'voice': voicePath,
          'video': videoPath,
          'picture': picturePath,
          'days': days,
          'is_active': isActive,
          'category': category.index + 1,
        },
      );
      if (category == AppRadioCategories.top_Ads) {
        categoryOnePagingController.insertItem(0,
            AppRadioModel.fromMap(result.data['data'] as Map<String, dynamic>));
      } else if (category == AppRadioCategories.top_Show) {
        categoryTwoPagingController.insertItem(0,
            AppRadioModel.fromMap(result.data['data'] as Map<String, dynamic>));
      } else {
        categoryThreePagingController.insertItem(0,
            AppRadioModel.fromMap(result.data['data'] as Map<String, dynamic>));
      }
      Get.back();
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void editItem(AppRadioModel appRadio) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      if (appRadio.picture != null && !appRadio.picture!.startsWith('http')) {
        final picturePath = await AppConstants.spaceBucket
            .uploadFile(appRadio.picture!, 'image/jpg', 'jpg');
        appRadio.picture = picturePath;
      }
      if (appRadio.video != null && !appRadio.video!.startsWith('http')) {
        final videoPath = await AppConstants.spaceBucket
            .uploadFile(appRadio.video!, 'video/mp4', 'mp4');
        appRadio.picture = videoPath;
      }
      if (appRadio.voice != null && !appRadio.voice!.startsWith('http')) {
        final voicePath = await AppConstants.spaceBucket
            .uploadFile(appRadio.voice!, 'audio/mp3', 'mp3');
        appRadio.picture = voicePath;
      }
      final result = await CustomDio().put(
        'super-admin/app-radio',
        body: {
          'id': appRadio.id,
          'is_active': appRadio.isActive,
          'days': appRadio.days,
          'text': appRadio.text,
          'type': appRadio.type.index + 1,
          'category': appRadio.category.index + 1,
          'voice': appRadio.voice?.replaceFirst(AppConstants.imageBaseUrl, ''),
          'video': appRadio.video?.replaceFirst(AppConstants.imageBaseUrl, ''),
          'picture':
              appRadio.picture?.replaceFirst(AppConstants.imageBaseUrl, ''),
        },
      );
      int index = categoryOnePagingController.itemList.indexOf(appRadio);
      if (index == -1)
        index = categoryTwoPagingController.itemList.indexOf(appRadio);
      if (index == -1)
        index = categoryThreePagingController.itemList.indexOf(appRadio);
      if (index != -1) {
        categoryOnePagingController.removeItem(appRadio);
        categoryTwoPagingController.removeItem(appRadio);
        categoryThreePagingController.removeItem(appRadio);
        if (appRadio.category == AppRadioCategories.top_Ads) {
          categoryOnePagingController.insertItem(
              index,
              AppRadioModel.fromMap(
                  result.data['data'] as Map<String, dynamic>));
        } else if (appRadio.category == AppRadioCategories.top_Show) {
          categoryTwoPagingController.insertItem(
              index,
              AppRadioModel.fromMap(
                  result.data['data'] as Map<String, dynamic>));
        } else {
          categoryThreePagingController.insertItem(
              index,
              AppRadioModel.fromMap(
                  result.data['data'] as Map<String, dynamic>));
        }
      }
      Get.back();
      CustomAlert.snackBar(msg: 'Success Item Edited.');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteConfirmDialog(AppRadioModel appRadio) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete this Item?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () => _deleteItem(appRadio),
    );
  }

  void _deleteItem(AppRadioModel appRadio) async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();
      await CustomDio().delete('super-admin/app-radio/${appRadio.id}');
      categoryOnePagingController.removeItem(appRadio);
      categoryTwoPagingController.removeItem(appRadio);
      categoryThreePagingController.removeItem(appRadio);
      Get.back();
      CustomAlert.snackBar(msg: 'Deleted Successfully');
    } catch (e) {
      Get.back();
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onClose() {
    categoryOnePagingController.dispose();
    categoryTwoPagingController.dispose();
    categoryThreePagingController.dispose();
    super.onClose();
  }
}
