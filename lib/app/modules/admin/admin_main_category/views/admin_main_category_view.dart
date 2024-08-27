import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/admin_main_category_controller.dart';

class AdminMainCategoryView extends GetView<AdminMainCategoryController> {
  const AdminMainCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Categories'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.mainCategories.length,
          itemBuilder: (_, index) {
            final mainCategory = controller.mainCategories[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () =>
                          controller.showEditNameArDialog(mainCategory),
                      child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: mainCategory.nameAr.text),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () =>
                          controller.showEditNameEnDialog(mainCategory),
                      child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: mainCategory.nameEn.text),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: mainCategory.bannerPath != null
                            ? Image.file(
                                File(mainCategory.bannerPath!),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: 80,
                              )
                            : CachedNetworkImage(
                                imageUrl: mainCategory.s3Banner,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: 80,
                              ),
                      ),
                      onTap: () => controller.pickBannerPicture(mainCategory),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () => controller.pickCoverPicture(mainCategory),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: mainCategory.coverPath != null
                            ? Image.file(
                                File(mainCategory.coverPath!),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: 450,
                              )
                            : CachedNetworkImage(
                                imageUrl: mainCategory.s3Cover,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: 450,
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      child: 'Save'.text,
                      color: Get.theme.primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: double.infinity,
                      onPressed: () => controller.saveCategory(mainCategory),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
