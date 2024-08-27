import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/helper/restaurant_search_delegate.dart';
import '../../../../data/model/restaurant_model.dart';
import '../controllers/restaurants_controller.dart';

class RestaurantsView extends GetView<RestaurantsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: RestaurantSearchDelegate(
                    onDeleteClick: (rider) =>
                        controller.showDeleteConfirmDialog(rider),
                    onCardClick: (rider) {
                      Get.bottomSheet(_buildRestaurantDetails(rider));
                    },
                    onBlockClick: (rider) =>
                        controller.showLockDialog(rider.user!.id),
                  ),
                );
              },
              icon: Icon(Icons.search))
        ],
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
    return InkWell(
      onTap: () {
        Get.bottomSheet(_buildRestaurantDetails(restaurant));
      },
      child: Card(
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
                  (restaurant.user?.fullName ?? '').text.bold.size(18),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(restaurant.user?.profilePicture ?? ''),
                  )
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              (Get.locale?.languageCode == 'ar'
                      ? restaurant.category!.nameAr
                      : restaurant.category!.nameEn)
                  .text,
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () =>
                          controller.showDeleteConfirmDialog(restaurant),
                      child: 'Delete Restaurant'.text,
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
                      onPressed: () =>
                          controller.showLockDialog(restaurant.userId),
                      child: 'Block'.text,
                      textColor: Colors.white,
                      color: Colors.deepOrange,
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
      ),
    );
  }

  Widget _buildRestaurantDetails(RestaurantModel restaurant) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  'Location'.text.bold.size(16),
                  SizedBox(width: 45),
                  Expanded(
                    child: Text(restaurant.location),
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
            ],
          ),
        ),
      ),
    );
  }
}
