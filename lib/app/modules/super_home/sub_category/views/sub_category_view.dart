import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/sub_category_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/sub_category_controller.dart';

class SubCategoryView extends GetView<SubCategoryController> {
  const SubCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Categories'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.subCategories.length,
          itemBuilder: (_, index) => _subCategoryWidget(
            controller.subCategories[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Get.theme.primaryColor,
        onPressed: () => Get.toNamed(
          Routes.ADD_SUB_CATEGORY,
          arguments: controller.mainCategory,
        ),
      ),
    );
  }

  Widget _subCategoryWidget(SubCategoryModel subCategory) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            subCategory.nameAr.text,
            SizedBox(height: 10),
            subCategory.nameEn.text,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomTextFieldWithBackground(
                label: 'Daily Price',
                initValue: subCategory.dailyPrice.toString(),
                onChange: (v) => subCategory.dailyPrice =
                    double.tryParse(v) ?? subCategory.dailyPrice,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextFieldWithBackground(
                label: 'Portion',
                initValue: subCategory.portion.toString(),
                onChange: (v) => subCategory.portion =
                    double.tryParse(v) ?? subCategory.portion,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextFieldWithBackground(
                label: 'Provider Portion',
                initValue: subCategory.providerPortion.toString(),
                onChange: (v) => subCategory.providerPortion =
                    double.tryParse(v) ?? subCategory.providerPortion,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextFieldWithBackground(
                label: 'Payment Factor',
                initValue: subCategory.paymentFactor.toString(),
                onChange: (v) => subCategory.paymentFactor =
                    double.tryParse(v) ?? subCategory.paymentFactor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextFieldWithBackground(
                label: 'Index',
                initValue: subCategory.index.toString(),
                onChange: (v) => subCategory.newIndex = int.tryParse(v),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                Clipboard.setData(
                  ClipboardData(text: subCategory.id),
                );
                CustomAlert.snackBar(
                  msg: 'The Category ID has been successfully copied',
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextFieldWithBackground(
                  label: 'Category Id',
                  initValue: subCategory.id.toString(),
                  enable: false,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'is Hidden'.text,
                ValueBuilder<bool?>(
                  initialValue: subCategory.isHidden,
                  onUpdate: (v) => subCategory.isHidden = v!,
                  builder: (value, update) => Switch(
                    value: value!,
                    onChanged: update,
                  ),
                )
              ],
            ),

            const SizedBox(height: 10),
            IconButton(
              onPressed: () => controller.showDeleteConfirm(subCategory.id),
              icon: Icon(
                Icons.clear,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            MaterialButton(
              child: 'Save'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () => controller.updateSubCategory(subCategory),
            ),
          ],
        ),
      ),
    );
  }
}
