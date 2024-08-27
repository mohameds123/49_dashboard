import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../data/model/post_feeling_model.dart';
import '../controllers/post_feeling_controller.dart';

class PostFeelingView extends GetView<PostFeelingController> {
  const PostFeelingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Feelings'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.feelings.length,
          itemBuilder: (_, index) => _buildFeeling(
            controller.feelings[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: Icon(Icons.add),
        onPressed: controller.showAddSheet,
      ),
    );
  }

  Widget _buildFeeling(PostFeelingModel feeling) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => controller.showEditSheet(feeling),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              feeling.nameAr.text,
              SizedBox(height: 10),
              feeling.nameEn.text,
              SizedBox(height: 10),
              if (feeling.picture != null)
                (feeling.picture!.endsWith('.svg')
                    ? SvgPicture.network(
                        feeling.picture!,
                        width: 70,
                        height: 50,
                      )
                    : CachedNetworkImage(
                        imageUrl: feeling.picture!,
                        width: 70,
                        height: 50,
                      )),
              if (feeling.picture != null) SizedBox(height: 10),
              IconButton(
                onPressed: () => controller.showDeleteFeelingDialog(feeling),
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
