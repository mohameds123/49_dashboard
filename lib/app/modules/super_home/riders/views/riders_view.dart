import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/helper/rider_search_delegate.dart';
import '../../../../data/model/rider_registration_info_model.dart';
import '../controllers/riders_controller.dart';

class RidersView extends GetView<RidersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riders'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: RiderSearchDelegate(
                    onDeleteClick: (rider) =>
                        controller.showDeleteConfirmDialog(rider),
                    onCardClick: (rider) {
                      Get.bottomSheet(_buildRiderDetails(rider));
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
        builderDelegate: PagedChildBuilderDelegate<RiderRegistrationInfoModel>(
          itemBuilder: (context, item, index) => _buildRiderCard(item),
        ),
      ),
    );
  }

  Widget _buildRiderCard(RiderRegistrationInfoModel rider) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(_buildRiderDetails(rider));
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
                  (rider.user?.fullName ?? '').text.bold.size(18),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(rider.user?.profilePicture ?? ''),
                  )
                ],
              ),
              SizedBox(height: 10),
              (Get.locale?.languageCode == 'ar'
                      ? rider.category.nameAr
                      : rider.category.nameEn)
                  .text,
              SizedBox(height: 10),
              rider.trips.toString().text,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () =>
                          controller.showDeleteConfirmDialog(rider),
                      child: 'Delete Rider'.text,
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
                          controller.showLockDialog(rider.user!.id),
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

  Widget _buildRiderDetails(RiderRegistrationInfoModel rider) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (rider.user?.fullName ?? '').text.bold.size(18),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(rider.user?.profilePicture ?? ''),
                  )
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              if (rider.pricingPerKm != 0) SizedBox(height: 5),
              if (rider.pricingPerKm != 0) Divider(),
              if (rider.pricingPerKm != 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Pricing Per KM'.text.bold.size(16),
                    rider.pricingPerKm.toString().text,
                  ],
                ),
              SizedBox(height: 5),
              Divider(),
              Row(
                children: [
                  'Car Brand'.text.bold.size(16),
                  SizedBox(width: 35),
                  Expanded(
                    child: Text(rider.carBrand),
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
                    child: Text(rider.carType),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              Row(
                children: [
                  'Plate Number'.text.bold.size(16),
                  SizedBox(width: 10),
                  Expanded(child: Text(rider.carPlateNumbers))
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              Row(
                children: [
                  'Plate Letters'.text.bold.size(16),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(rider.carPlateLetters),
                  ),
                ],
              ),
              Divider(),
              'Car Pictures'.text,
              SizedBox(height: 5),
              Row(
                children: List.generate(
                  rider.carPictures.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: CachedNetworkImage(
                        imageUrl: rider.carPictures[index],
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
                      imageUrl: rider.idFront,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: rider.idBehind,
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
                      imageUrl: rider.drivingLicenseFront,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: rider.drivingLicenseBehind,
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
                      imageUrl: rider.carLicenseFront,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: rider.carLicenseBehind,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Divider(),
              'Criminal Record'.text,
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 10),
                  if (rider.criminalRecord != null)
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: rider.criminalRecord!,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                ],
              ),
              Divider(),
              'Technical Examination / Drug Analysis'.text,
              SizedBox(height: 5),
              Row(
                children: [
                  if (rider.technicalExamination != null)
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: rider.technicalExamination!,
                        height: 100,
                        width: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                  SizedBox(width: 10),
                  if (rider.drugAnalysis != null)
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: rider.drugAnalysis!,
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
