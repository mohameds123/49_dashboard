import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/helper/loading_search_delegate.dart';
import '../../../../data/model/loading_model.dart';
import '../controllers/loadings_controller.dart';

class LoadingsView extends GetView<LoadingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loadings'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: LoadingSearchDelegate(
                    onDeleteClick: (rider) =>
                        controller.showDeleteConfirmDialog(rider),
                    onCardClick: (rider) {
                      Get.bottomSheet(_buildLoadingDetails(rider));
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
        pagingController: controller.ridersPagingController,
        builderDelegate: PagedChildBuilderDelegate<LoadingModel>(
          itemBuilder: (context, item, index) => _buildLoadingCard(item),
        ),
      ),
    );
  }

  Widget _buildLoadingCard(LoadingModel loading) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(_buildLoadingDetails(loading));
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
                  loading.user!.fullName.text.bold.size(18),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(loading.user!.profilePicture),
                  )
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              (Get.locale?.languageCode == 'ar'
                      ? loading.category.nameAr
                      : loading.category.nameEn)
                  .text,
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () =>
                          controller.showDeleteConfirmDialog(loading),
                      child: 'Delete Loading'.text,
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
                          controller.showLockDialog(loading.user!.id),
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

  Widget _buildLoadingDetails(LoadingModel loading) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  'Car Brand'.text.bold.size(16),
                  SizedBox(width: 35),
                  Expanded(
                    child: Text(loading.carBrand),
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
                    child: Text(loading.carType),
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
                    child: Text(loading.location),
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
              Divider(),
              'ID Card'.text,
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: loading.idFront,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: loading.idBehind,
                      height: 100,
                      fit: BoxFit.fill,
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
                    child: CachedNetworkImage(
                      imageUrl: loading.drivingLicenseFront,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: loading.drivingLicenseBehind,
                      height: 100,
                      fit: BoxFit.fill,
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
                    child: CachedNetworkImage(
                      imageUrl: loading.carLicenseFront,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: loading.carLicenseBehind,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
