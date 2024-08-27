import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../data/model/post_activity_model.dart';
import '../controllers/post_activity_controller.dart';

class PostActivityView extends GetView<PostActivityController> {
  const PostActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Activities'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.activities.length,
          itemBuilder: (_, index) => _buildActivity(
            controller.activities[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: Icon(Icons.add),
        onPressed: controller.showAddSheet  ,
      ),
    );
  }

  Widget _buildActivity(PostActivityModel activity) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => controller.showEditActivityDialog(activity),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              activity.nameAr.text,
              SizedBox(height: 10),
              activity.nameEn.text,
              SizedBox(height: 10),
              if (activity.picture != null)
                (activity.picture!.endsWith('.svg')
                    ? SvgPicture.network(
                        activity.picture!,
                        width: 70,
                        height: 50,
                      )
                    : CachedNetworkImage(
                        imageUrl: activity.picture!,
                        width: 70,
                        height: 50,
                      )),
              if (activity.picture != null) SizedBox(height: 10),
              IconButton(
                onPressed: () => controller.showDeleteActivityDialog(activity),
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
