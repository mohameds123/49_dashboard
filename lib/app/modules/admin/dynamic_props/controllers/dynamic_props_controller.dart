import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/enums.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/dynamic/dynamic_multi_selected_model.dart';
import '../../../../data/model/dynamic/dynamic_prop_model.dart';
import '../../../../data/model/main_category_model.dart';
import '../../../../data/model/sub_category_model.dart';

class DynamicPropsController extends GetxController {
  final mainCategories = RxList<MainCategoryModel>();
  final subCategories = RxList<SubCategoryModel>();

  String? currentMainCategory;

  void getMainCategories() async {
    try {
      final result = await CustomDio().get('admin/main-categories');

      final data = (result.data['data'] as List)
          .map((e) => MainCategoryModel.fromMap(e))
          .toList();
      data.sort((a, b) => a.index.compareTo(b.index));
      mainCategories.value = data.sublist(4);
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

  void editPropNameAr(DynamicPropModel prop) {
    String nameAr = prop.nameAr;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Edit Property Name Ar'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Name Ar',
              initValue: nameAr,
              onChange: (v) => nameAr = v,
            ),
            SizedBox(height: 15),
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
                prop.nameAr = nameAr;
                subCategories.refresh();
              },
            )
          ],
        ),
      ),
    );
  }

  void editPropNameEn(DynamicPropModel prop) {
    String nameEn = prop.nameEn;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Edit Property Name En'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Name En',
              initValue: nameEn,
              onChange: (v) => nameEn = v,
            ),
            SizedBox(height: 15),
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
                prop.nameEn = nameEn;
                subCategories.refresh();
              },
            )
          ],
        ),
      ),
    );
  }

  void editPropIndex(DynamicPropModel prop, List<DynamicPropModel> props) {
    int index = prop.index;

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Edit Property Index'.text,
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Index',
              initValue: index.toString(),
              onChange: (v) => index = int.tryParse(v) ?? index,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 15),
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
                if (index >= props.length) {
                  index = props.length - 1;
                }
                props.remove(prop);
                props.insert(index, prop);
                for (int i = 0; i < props.length; i++) {
                  props[i].index = i;
                }
                subCategories.refresh();
              },
            )
          ],
        ),
      ),
    );
  }

  void deleteProp(DynamicPropModel prop, SubCategoryModel subCategory) {
    subCategory.props.remove(prop);

    for (int i = 0; i < subCategory.props.length; i++) {
      subCategory.props[i].index = i;
    }
    subCategories.refresh();
  }

  final addingProp = Rxn<DynamicPropModel>();

  void addProp(SubCategoryModel subCategory, {DynamicPropModel? prop}) {
    if (prop != null) {
      addingProp.value = prop.copyWith();
    } else {
      addingProp.value = DynamicPropModel(
          id: '',
          nameAr: '',
          nameEn: '',
          selections: [
            DynamicMultiSelectionsModel(nameAr: '', nameEn: ''),
            DynamicMultiSelectionsModel(nameAr: '', nameEn: ''),
          ],
          value: '',
          values: [],
          index: 0);
    }
    Get.bottomSheet(
      Material(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<DynamicAdInputType>(
                    isExpanded: true,
                    hint: 'Type'.text,
                    value: addingProp.value?.type,
                    items: DynamicAdInputType.values
                        .skip(3)
                        .where((e) => prop != null &&
                                (prop.type == DynamicAdInputType.dropDown ||
                                    prop.type == DynamicAdInputType.checkBox)
                            ? (e == DynamicAdInputType.checkBox ||
                                e == DynamicAdInputType.dropDown)
                            : true)
                        .map((e) => DropdownMenuItem(
                            value: e, child: e.name.capitalize!.text))
                        .toList(),
                    onChanged: (v) {
                      addingProp.value?.type = v!;
                      if ((addingProp.value!.type ==
                                  DynamicAdInputType.checkBox ||
                              addingProp.value!.type ==
                                  DynamicAdInputType.dropDown) &&
                          addingProp.value!.selections.isEmpty) {
                        addingProp.value!.selections = [
                          DynamicMultiSelectionsModel(nameAr: '', nameEn: ''),
                          DynamicMultiSelectionsModel(nameAr: '', nameEn: ''),
                        ];
                      }
                      addingProp.refresh();
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextFieldWithBackground(
                    label: 'Name Ar',
                    initValue: addingProp.value!.nameAr,
                    onChange: (v) => addingProp.value!.nameAr = v,
                  ),
                  SizedBox(height: 10),
                  CustomTextFieldWithBackground(
                    label: 'Name En',
                    initValue: addingProp.value!.nameEn,
                    onChange: (v) => addingProp.value!.nameEn = v,
                  ),
                  if (addingProp.value!.type == DynamicAdInputType.checkBox ||
                      addingProp.value!.type == DynamicAdInputType.dropDown)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          ...addingProp.value!.selections.map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextFieldWithBackground(
                                    label: 'Name Ar',
                                    height: 50,
                                    width: Get.width * .40,
                                    initValue: e.nameAr,
                                    onChange: (v) => e.nameAr = v,
                                  ),
                                  CustomTextFieldWithBackground(
                                    label: 'Name En',
                                    height: 50,
                                    width: Get.width * .40,
                                    initValue: e.nameEn,
                                    onChange: (v) => e.nameEn = v,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (addingProp.value!.selections.length >
                                          2) {
                                        addingProp.value!.selections.remove(e);
                                        addingProp.refresh();
                                      }
                                    },
                                    icon: Icon(Icons.clear),
                                  )
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              addingProp.value!.selections.add(
                                DynamicMultiSelectionsModel(
                                    nameAr: '', nameEn: ''),
                              );
                              addingProp.refresh();
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                          )
                        ],
                      ),
                    ),
                  SizedBox(height: 10),
                  MaterialButton(
                    child: (prop == null ? 'Add' : 'Edit').text,
                    color: Colors.green,
                    disabledColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: Get.width,
                    textColor: Colors.white,
                    onPressed: addingProp.value!.type == null
                        ? null
                        : () async {
                            if (addingProp.value!.nameAr.isEmpty ||
                                addingProp.value!.nameEn.isEmpty ||
                                ((addingProp.value!.type ==
                                            DynamicAdInputType.dropDown ||
                                        addingProp.value!.type ==
                                            DynamicAdInputType.checkBox) &&
                                    (addingProp.value!.selections
                                                .firstWhereOrNull(
                                                    (e) => e.nameAr.isEmpty) !=
                                            null ||
                                        addingProp.value!.selections
                                                .firstWhereOrNull(
                                                    (e) => e.nameEn.isEmpty) !=
                                            null))) {
                              CustomAlert.showError('Fill All Name Fields');
                            } else {
                              Get.close(1);
                              if (addingProp.value!.type !=
                                      DynamicAdInputType.dropDown &&
                                  addingProp.value!.type !=
                                      DynamicAdInputType.checkBox) {
                                addingProp.value!.selections.clear();
                              }
                              if (prop != null) {
                                final index = subCategory.props.indexOf(prop);
                                if (index != -1) {
                                  subCategory.props.removeAt(index);
                                  subCategory.props
                                      .insert(index, addingProp.value!);
                                }
                              } else {
                                if (subCategory.props.isEmpty)
                                  addingProp.value!.index = 0;
                                else
                                  addingProp.value!.index =
                                      subCategory.props.last.index + 1;
                                subCategory.props.add(addingProp.value!);
                              }
                              subCategories.refresh();
                            }
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

  void showSaveDialog(SubCategoryModel subCategory) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'are you sure you want to save changes?',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      textCancel: 'No',
      onConfirm: () => saveProps(subCategory),
    );
  }

  void saveProps(SubCategoryModel subCategory) async {
    try {
      Get.back();
      final result = await CustomDio().put(
        'admin/dynamic-props',
        body: {
          'category_id': subCategory.id,
          'props': subCategory.props.map((e) => e.toMap()).toList(),
        },
      );
      subCategory.props = (result.data['data'] as List)
          .map((e) => DynamicPropModel.fromMap(e))
          .toList();
      CustomAlert.snackBar(msg: 'Success Dynamic Properties.');
      subCategories.refresh();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  @override
  void onInit() {
    getMainCategories();
    super.onInit();
  }
}
