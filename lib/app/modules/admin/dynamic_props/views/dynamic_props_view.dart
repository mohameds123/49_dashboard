import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../data/model/sub_category_model.dart';
import '../controllers/dynamic_props_controller.dart';

class DynamicPropsView extends StatelessWidget {
  DynamicPropsView({super.key});

  final controller = Get.find<DynamicPropsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Properties'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueBuilder<String?>(
              onUpdate: controller.onMainCategoryChanged,
              builder: (value, update) => Obx(
                () => DropdownButton(
                    hint: 'Main Category'.text,
                    isExpanded: true,
                    value: value,
                    items: controller.mainCategories
                        .map(
                          (e) => DropdownMenuItem(
                              value: e.id, child: e.nameEn.text),
                        )
                        .toList(),
                    onChanged: update),
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.separated(
                  itemCount: controller.subCategories.length,
                  itemBuilder: (_, index) =>
                      _buildCategoryCard(controller.subCategories[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(SubCategoryModel subCategory) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subCategory.nameAr.text.bold
                    .size(20)
                    .color(Get.theme.primaryColor),
                subCategory.nameEn.text.bold
                    .size(20)
                    .color(Get.theme.primaryColor),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            ...subCategory.props.map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => controller.editPropNameAr(e),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Name Ar'.text,
                          e.nameAr.text,
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () => controller.editPropNameEn(e),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Name En'.text,
                          e.nameEn.text,
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () => controller.editPropIndex(e, subCategory.props),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Index'.text,
                          e.index.toString().text,
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () => controller.addProp(subCategory, prop: e),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Type'.text,
                          e.type!.name.capitalize!.text,
                        ],
                      ),
                    ),
                  ),
                  if (e.selections.isNotEmpty) SizedBox(height: 10),
                  if (e.selections.isNotEmpty)
                    InkWell(
                      onTap: () => controller.addProp(subCategory, prop: e),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            'Selections'.text,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: e.selections
                                    .map(
                                        (e) => '${e.nameAr} | ${e.nameEn}'.text)
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  MaterialButton(
                    child: 'Delete'.text,
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () => controller.deleteProp(e, subCategory),
                  ),
                  Divider(color: Get.theme.primaryColor),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  child: 'Save'.text,
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () => controller.showSaveDialog(subCategory),
                ),
                MaterialButton(
                  child: 'Add'.text,
                  color: Get.theme.primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () => controller.addProp(subCategory),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
