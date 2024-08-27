import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/doctor_model.dart';
import '../controllers/review_health_controller.dart';

class ReviewHealthView extends GetView<ReviewHealthController> {
  const ReviewHealthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Health'),
        centerTitle: true,
      ),
      body: PagedListView(
        pagingController: controller.doctorsPagingController,
        builderDelegate: PagedChildBuilderDelegate<DoctorModel>(
          itemBuilder: (context, item, index) => _buildDoctorCard(item),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(DoctorModel doctor) {
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
                (doctor.user?.fullName ?? '').text.bold.size(18),
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(doctor.user?.profilePicture ?? ''),
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
                        ? doctor.category!.nameAr
                        : doctor.category!.nameEn)
                    .text,
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Specialty'.text.bold.size(16),
                SizedBox(width: 35),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: doctor.specialty,
                    onChange: (v) => doctor.specialty = v,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              children: [
                'Location'.text.bold.size(16),
                SizedBox(width: 38),
                Expanded(
                  child: CustomTextFieldWithBackground(
                    initValue: doctor.location,
                    onChange: (v) => doctor.location = v,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            'Picture'.text,
            SizedBox(height: 5),
            InkWell(
              onTap: () => controller.onPictureClick(doctor, 0),
              child: Hero(
                tag: doctor.picture,
                child: CachedNetworkImage(
                  imageUrl: doctor.picture,
                  height: 100,
                  width: 250,
                  fit: BoxFit.fill,
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
                    onTap: () => controller.onPictureClick(doctor, 1),
                    child: Hero(
                      tag: doctor.idFront,
                      child: CachedNetworkImage(
                        imageUrl: doctor.idFront,
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
                    onTap: () => controller.onPictureClick(doctor, 2),
                    child: Hero(
                      tag: doctor.idBehind,
                      child: CachedNetworkImage(
                        imageUrl: doctor.idBehind,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            'Practice License'.text,
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => controller.onPictureClick(doctor, 3),
                    child: Hero(
                      tag: doctor.practiceLicenseFront,
                      child: CachedNetworkImage(
                        imageUrl: doctor.practiceLicenseFront,
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
                    onTap: () => controller.onPictureClick(doctor, 4),
                    child: Hero(
                      tag: doctor.practiceLicenseBehind,
                      child: CachedNetworkImage(
                        imageUrl: doctor.practiceLicenseBehind,
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
                    onPressed: () => controller.showDeclineDialog(doctor),
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
                    onPressed: () => controller.showApproveDialog(doctor),
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
