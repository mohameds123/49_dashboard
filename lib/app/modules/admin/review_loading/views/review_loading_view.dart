import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/loading_model.dart';
import '../controllers/review_loading_controller.dart';

class ReviewLoadingView extends GetView<ReviewLoadingController> {
  const ReviewLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Loading'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.loadingsPagingController,
        builderDelegate: PagedChildBuilderDelegate<LoadingModel>(
          itemBuilder: (context, item, index) => _buildLoadingCard(item),
        ),
      ),
    );
  }

  Widget _buildLoadingCard(LoadingModel loading) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                loading.user!.fullName.text.bold.size(18),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(loading.user!.profilePicture),
                )
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Category'.text.bold.size(16),
                (Get.locale?.languageCode == 'ar'
                        ? loading.category.nameAr
                        : loading.category.nameEn)
                    .text,
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Car Brand'.text.bold.size(16),
                SizedBox(width: 35),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: loading.carBrand,
                    onChange: (v) => loading.carBrand = v,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Car Type'.text.bold.size(16),
                SizedBox(width: 44),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: loading.carType,
                    onChange: (v) => loading.carType = v,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Location'.text.bold.size(16),
                SizedBox(width: 45),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: loading.location,
                    onChange: (v) => loading.location = v,
                  ),
                ),
              ],
            ),
            Divider(),
            'Car Pictures'.text,
            SizedBox(height: 5),
            Row(
              children: List.generate(
                loading.carPictures.length,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: InkWell(
                      onTap: () => controller.onPictureClick(loading, index),
                      child: Hero(
                        tag: loading.carPictures[index],
                        child: CachedNetworkImage(
                          imageUrl: loading.carPictures[index],
                          height: 100,
                          width: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            'ID Card'.text,
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => controller.onPictureClick(
                        loading, loading.carPictures.length + 1),
                    child: Hero(
                      tag: loading.idFront,
                      child: CachedNetworkImage(
                        imageUrl: loading.idFront,
                        height: 100,
                        width: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () => controller.onPictureClick(
                        loading, loading.carPictures.length + 2),
                    child: Hero(
                      tag: loading.idBehind,
                      child: CachedNetworkImage(
                        imageUrl: loading.idBehind,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            'Driving License'.text,
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => controller.onPictureClick(
                        loading, loading.carPictures.length + 3),
                    child: Hero(
                      tag: loading.drivingLicenseFront,
                      child: CachedNetworkImage(
                        imageUrl: loading.drivingLicenseFront,
                        height: 100,
                        width: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () => controller.onPictureClick(
                        loading, loading.carPictures.length + 4),
                    child: Hero(
                      tag: loading.drivingLicenseBehind,
                      child: CachedNetworkImage(
                        imageUrl: loading.drivingLicenseBehind,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            'Car License'.text,
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => controller.onPictureClick(
                        loading, loading.carPictures.length + 5),
                    child: Hero(
                      tag: loading.carLicenseFront,
                      child: CachedNetworkImage(
                        imageUrl: loading.carLicenseFront,
                        height: 100,
                        width: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () => controller.onPictureClick(
                        loading, loading.carPictures.length + 6),
                    child: Hero(
                      tag: loading.carLicenseBehind,
                      child: CachedNetworkImage(
                        imageUrl: loading.carLicenseBehind,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () => controller.showDeclineDialog(loading),
                    child: 'Decline'.text,
                    textColor: Colors.white,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MaterialButton(
                    onPressed: () => controller.showApproveDialog(loading),
                    child: 'Approve'.text,
                    textColor: Colors.white,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
