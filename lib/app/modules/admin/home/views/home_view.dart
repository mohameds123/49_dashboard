import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: 'Main Categories'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ADMIN_MAIN_CATEGORY);
              },
            ),
            ListTile(
              title: 'Sub Categories'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ADMIN_SUB_CATEGORY);
              },
            ),
            ListTile(
              title: 'Dynamic Properties'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.DYNAMIC_PROPS);
              },
            ),
            ListTile(
              title: 'Users'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ADMIN_USERS);
              },
            ),
            ListTile(
              title: 'Post Feelings'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.POST_FEELING);
              },
            ),
            ListTile(
              title: 'Post Activities'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.POST_ACTIVITY);
              },
            ),
            ListTile(
              title: 'Come With Me Trips'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.COME_WITH_ME_TRIPS);
              },
            ),
            ListTile(
              title: 'Review Come With Me'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REVIEW_COME_WITH_ME_TRIPS);
              },
            ),
            ListTile(
              title: 'Pick Me Trips'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.PICK_ME_TRIPS);
              },
            ),
            ListTile(
              title: 'Review Pick Me'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REVIEW_PICK_ME_TRIPS);
              },
            ),
            // ListTile(
            //   title: 'App Radio'.text,
            //   onTap: () {
            //     Get.back();
            //     Get.toNamed(Routes.APP_RADIO);
            //   },
            // ),
            /*ListTile(
              title: 'Songs'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.SONGS);
              },
            ),*/
            ListTile(
              title: 'Logout'.text,
              onTap: () {
                Get.back();
                controller.showLogoutConfirmDialog();
              },
            ),
          ],
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getData,
          child: ListView(
            children: [
              _buildActionCard(
                'Review Ads',
                controller.adsReviewCounts.value,
                () => Get.toNamed(Routes.REVIEW_ADS),
              ),
              _buildActionCard(
                'Review Ride',
                controller.rideReviewCounts.value,
                () => Get.toNamed(Routes.REVIEW_RIDE),
              ),
              _buildActionCard(
                'Review Loading',
                controller.loadingReviewCounts.value,
                () => Get.toNamed(Routes.REVIEW_LOADING),
              ),
              _buildActionCard(
                'Review Restaurants',
                controller.restaurantsReviewCounts.value,
                () => Get.toNamed(Routes.REVIEW_RESTAURANT),
              ),
              _buildActionCard(
                'Review Health',
                controller.healthReviewCounts.value,
                () => Get.toNamed(Routes.REVIEW_HEALTH),
              ),
              _buildActionCard(
                'Review Food',
                controller.foodReviewCounts.value,
                () => Get.toNamed(Routes.REVIEW_FOOD),
              ),
              _buildActionCard(
                'Reports',
                controller.reportsCounts.value,
                () => Get.toNamed(Routes.REPORTS),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(String label, int count, VoidCallback onClick) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [label.text.size(25), count.toString().text.size(16)],
          ),
        ),
      ),
    );
  }
}
