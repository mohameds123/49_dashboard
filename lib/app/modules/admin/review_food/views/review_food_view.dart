import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/food_item_model.dart';
import '../controllers/review_food_controller.dart';

class ReviewFoodView extends GetView<ReviewFoodController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Food'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.foodsPagingController,
        builderDelegate: PagedChildBuilderDelegate<FoodItemModel>(
          itemBuilder: (context, item, index) => _buildFoodCard(item),
        ),
      ),
    );
  }

  Widget _buildFoodCard(FoodItemModel food) {
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
                'Restaurant'.text.bold.size(16),
                food.restaurantName.text,
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Name'.text.bold.size(16),
                SizedBox(width: 35),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: food.name,
                    onChange: (v) => food.name = v,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Desc'.text.bold.size(16),
                SizedBox(width: 44),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: food.desc,
                    onChange: (v) => food.desc = v,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Price'.text.bold.size(16),
                SizedBox(width: 44),
                food.price.toString().text,
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            if (food.picture != null) 'Picture'.text,
            if (food.picture != null) SizedBox(height: 5),
            if (food.picture != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: InkWell(
                  onTap: () => controller.onPictureClick(food),
                  child: Hero(
                    tag: food.picture!,
                    child: CachedNetworkImage(
                      imageUrl: food.picture!,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () => controller.decline(food),
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
                    onPressed: () => controller.approve(food),
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
