import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../data/model/gift_model.dart';
import '../controllers/gifts_controller.dart';

class GiftsView extends GetView<GiftsController> {
  const GiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gifts'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.gifts.length,
          itemBuilder: (_, index) => _buildGiftWidget(
            controller.gifts[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Get.theme.primaryColor,
        onPressed: controller.showAddSheet,
      ),
    );
  }

  Widget _buildGiftWidget(GiftModel gift) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () => controller.showEditSheet(gift),
          leading: CachedNetworkImage(
            imageUrl: gift.picture,
            width: 70,
            height: 50,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [gift.nameAr.text, gift.nameEn.text],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gift.value.toString().text,
              InkWell(
                onTap: () => controller.showDeleteConfirmDialog(gift),
                child: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
