import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textless/textless.dart';

import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../controllers/add_sub_category_controller.dart';

class AddSubCategoryView extends GetView<AddSubCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Sub Category'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFieldWithBackground(
                  label: 'Name Ar',
                  onChange: (v) => controller.nameAr = v,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFieldWithBackground(
                  label: 'Name En',
                  onChange: (v) => controller.nameEn = v,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFieldWithBackground(
                  label: 'Daily Price',
                  textInputType: TextInputType.number,
                  onChange: (v) =>
                      controller.dailyPrice = double.tryParse(v) ?? 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFieldWithBackground(
                  label: 'Portion',
                  textInputType: TextInputType.number,
                  onChange: (v) => controller.portion = double.tryParse(v) ?? 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFieldWithBackground(
                  label: 'Provider Portion',
                  textInputType: TextInputType.number,
                  onChange: (v) =>
                      controller.providerPortion = double.tryParse(v) ?? 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFieldWithBackground(
                  label: 'Payment Factor',
                  textInputType: TextInputType.number,
                  onChange: (v) =>
                      controller.paymentFactor = double.tryParse(v) ?? 0,
                ),
              ),
              MaterialButton(
                child: 'Add'.text,
                color: Get.theme.primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: double.infinity,
                onPressed: controller.addCategory,
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (result != null) {
            controller.picture = result.path;
            CustomAlert.snackBar(msg: 'Success Selected Picture.');
          }
        },
        backgroundColor: Get.theme.primaryColor,
        child: Icon(Icons.photo),
      ),
    );
  }
}
