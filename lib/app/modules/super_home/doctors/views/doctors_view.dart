import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/doctor_search_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../data/model/doctor_model.dart';
import '../controllers/doctors_controller.dart';

class DoctorsView extends GetView<DoctorsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DoctorSearchDelegate(
                    onDeleteClick: (rider) =>
                        controller.showDeleteConfirmDialog(rider),
                    onCardClick: (rider) {
                      Get.bottomSheet(_buildDoctorDetails(rider));
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
        pagingController: controller.doctorsPagingController,
        builderDelegate: PagedChildBuilderDelegate<DoctorModel>(
          itemBuilder: (context, item, index) => _buildDoctorCard(item),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(DoctorModel doctor) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(_buildDoctorDetails(doctor));
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
              (Get.locale?.languageCode == 'ar'
                      ? doctor.category!.nameAr
                      : doctor.category!.nameEn)
                  .text,
              SizedBox(height: 5),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () =>
                          controller.showDeleteConfirmDialog(doctor),
                      child: 'Delete Doctor'.text,
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
                      onPressed: () => controller.showLockDialog(doctor.userId),
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

  Widget _buildDoctorDetails(DoctorModel doctor) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Divider(),
              Row(
                children: [
                  'Specialty'.text.bold.size(16),
                  SizedBox(width: 35),
                  Expanded(
                    child: Text(doctor.specialty),
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
                    child: Text(doctor.location),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              'Picture'.text,
              SizedBox(height: 5),
              CachedNetworkImage(
                imageUrl: doctor.picture,
                height: 100,
                width: 250,
                fit: BoxFit.fill,
              ),
              Divider(),
              'ID Card'.text,
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: doctor.idFront,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: doctor.idBehind,
                      height: 100,
                      fit: BoxFit.fill,
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
                    child: CachedNetworkImage(
                      imageUrl: doctor.practiceLicenseFront,
                      height: 100,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: doctor.practiceLicenseBehind,
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
