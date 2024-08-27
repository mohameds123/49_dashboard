import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../controllers/admin_sub_category_controller.dart';

class AdminSubCategoryView extends GetView<AdminSubCategoryController> {
  const AdminSubCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Categories'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
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
              Expanded(
                child: ListView.builder(
                  itemCount: controller.subCategories.length,
                  itemBuilder: (_, index) {
                    final subCategory = controller.subCategories[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () =>
                                  controller.showEditNameArDialog(subCategory),
                              child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: subCategory.nameAr.text),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () =>
                                  controller.showEditNameEnDialog(subCategory),
                              child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: subCategory.nameEn.text),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              child: Container(
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.all(3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: subCategory.picturePath != null
                                      ? Image.file(
                                          File(subCategory.picturePath!),
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: subCategory.picture,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              onTap: () => controller.pickPicture(subCategory),
                            ),
                            MaterialButton(
                              child: 'Save'.text,
                              color: Get.theme.primaryColor,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minWidth: double.infinity,
                              onPressed: () =>
                                  controller.saveCategory(subCategory),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
