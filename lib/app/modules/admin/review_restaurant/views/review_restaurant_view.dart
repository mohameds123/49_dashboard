import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/restaurant_model.dart';
import '../controllers/review_restaurant_controller.dart';

class ReviewRestaurantView extends GetView<ReviewRestaurantController> {
  const ReviewRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Restaurant'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.restaurantsPagingController,
        builderDelegate: PagedChildBuilderDelegate<RestaurantModel>(
          itemBuilder: (context, item, index) => _buildRestaurantCard(item),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(RestaurantModel restaurant) {
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
                restaurant.user!.fullName.text.bold.size(18),
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(restaurant.user!.profilePicture),
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
                        ? restaurant.category!.nameAr
                        : restaurant.category!.nameEn)
                    .text,
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
                    initValue: restaurant.location,
                    onChange: (v) => restaurant.location = v,
                  ),
                ),
              ],
            ),
            Divider(),
            'Restaurant Pictures'.text,
            SizedBox(height: 5),
            Row(
              children: List.generate(
                restaurant.pictures.length,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: InkWell(
                      onTap: () => controller.onPictureClick(restaurant, index),
                      child: Hero(
                        tag: restaurant.pictures[index],
                        child: CachedNetworkImage(
                          imageUrl: restaurant.pictures[index],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () => controller.showDeclineDialog(restaurant),
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
                    onPressed: () => controller.showApproveDialog(restaurant),
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
