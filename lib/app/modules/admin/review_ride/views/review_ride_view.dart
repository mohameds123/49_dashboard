import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/rider_registration_info_model.dart';
import '../controllers/review_ride_controller.dart';

class ReviewRideView extends GetView<ReviewRideController> {
  const ReviewRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Riders'),
        centerTitle: true,
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
                (rider.user?.fullName ?? '').text.bold.size(18),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(rider.user?.profilePicture ?? ''),
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
                        ? rider.category.nameAr
                        : rider.category.nameEn)
                    .text,
              ],
            ),
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
                  child: CustomTextFieldWithBackground(
                    initValue: rider.carBrand,
                    onChange: (v) => rider.carBrand = v,
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
                    initValue: rider.carType,
                    onChange: (v) => rider.carType = v,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Plate Number'.text.bold.size(16),
                SizedBox(width: 10),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: rider.carPlateNumbers,
                    onChange: (v) => rider.carPlateNumbers = v,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Plate Letters'.text.bold.size(16),
                SizedBox(width: 15),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: rider.carPlateLetters,
                    onChange: (v) => rider.carPlateLetters = v,
                  ),
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
                    child: InkWell(
                      onTap: () => controller.onPictureClick(rider, index),
                      child: Hero(
                        tag: rider.carPictures[index],
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
                        rider, rider.carPictures.length + 1),
                    child: Hero(
                      tag: rider.idFront,
                      child: CachedNetworkImage(
                        imageUrl: rider.idFront,
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
                        rider, rider.carPictures.length + 2),
                    child: Hero(
                      tag: rider.idBehind,
                      child: CachedNetworkImage(
                        imageUrl: rider.idBehind,
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
                        rider, rider.carPictures.length + 3),
                    child: Hero(
                      tag: rider.drivingLicenseFront,
                      child: CachedNetworkImage(
                        imageUrl: rider.drivingLicenseFront,
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
                        rider, rider.carPictures.length + 4),
                    child: Hero(
                      tag: rider.drivingLicenseBehind,
                      child: CachedNetworkImage(
                        imageUrl: rider.drivingLicenseBehind,
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
                        rider, rider.carPictures.length + 5),
                    child: Hero(
                      tag: rider.carLicenseFront,
                      child: CachedNetworkImage(
                        imageUrl: rider.carLicenseFront,
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
                        rider, rider.carPictures.length + 6),
                    child: Hero(
                      tag: rider.carLicenseBehind,
                      child: CachedNetworkImage(
                        imageUrl: rider.carLicenseBehind,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
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
                    child: InkWell(
                      onTap: () => controller.onPictureClick(
                          rider, rider.carPictures.length + 8),
                      child: Hero(
                        tag: rider.criminalRecord!,
                        child: CachedNetworkImage(
                          imageUrl: rider.criminalRecord!,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
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
                    child: InkWell(
                      onTap: () => controller.onPictureClick(
                          rider, rider.carPictures.length + 9),
                      child: Hero(
                        tag: rider.technicalExamination!,
                        child: CachedNetworkImage(
                          imageUrl: rider.technicalExamination!,
                          height: 100,
                          width: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                SizedBox(width: 10),
                if (rider.drugAnalysis != null)
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.onPictureClick(
                          rider, rider.carPictures.length + 10),
                      child: Hero(
                        tag: rider.drugAnalysis!,
                        child: CachedNetworkImage(
                          imageUrl: rider.drugAnalysis!,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () => controller.showDeclineDialog(rider),
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
                    onPressed: () => controller.showApproveDialog(rider),
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
