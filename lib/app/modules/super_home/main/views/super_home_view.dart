import 'package:flutter/material.dart';
import 'package:fourtynine_dashboard/app/modules/admin/change_user_name_password/views/change_user_name_and_pass_view.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/super_home_controller.dart';

class SuperHomeView extends GetView<SuperHomeController> {
  const SuperHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Super Admin Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: 'Super admin control'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ChangeUserNameAndPass);
              },
            ),
            ListTile(
              title: 'User Wallets'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Users Profile'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ALLUSERSPROFILES);
              },
            ),

            ListTile(
              title: 'App Manager'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Storage'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Payment Gateway'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'PHome page Control'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Security'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Cat/Sup.Cat control'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Cash Back Control'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Competions control'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Luck Weel control'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Ride Control'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Gift Control'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),

            ListTile(
              title: 'dynamic apis'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Dynamic roles'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Contest'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'subscription'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Cash in approval'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Cash out approval'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Documantaion approval'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Review Ride register'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Review Shipping register'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Review Meal Register'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Review Health Register'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Review ads'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Review  Company ads'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Reports'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Reports'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_MANAGER);
              },
            ),
            ListTile(
              title: 'Main Categories'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.MAIN_CATEGORY);
              },
            ),
            ListTile(
              title: 'Users'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.USERS);
              },
            ),
            ListTile(
              title: 'Running Cost'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.RUNNING_COST);
              },
            ),
            ListTile(
              title: 'Admins'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.ADMINS);
              },
            ),
            ListTile(
              title: 'Gifts'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.GIFTS);
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
              title: 'App Radio'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.APP_RADIO);
              },
            ),
            ListTile(
              title: 'Dynamic Ads'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.DYNAMIC_ADS);
              },
            ),
            ListTile(
              title: 'Dynamic Ads Review'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REVIEW_ADS);
              },
            ),
            ListTile(
              title: 'Riders'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.RIDERS);
              },
            ),
            ListTile(
              title: 'Review Riders'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REVIEW_RIDE);
              },
            ),
            ListTile(
              title: 'Loadings'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.LOADINGS);
              },
            ),
            ListTile(
              title: 'Review Loadings'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REVIEW_LOADING);
              },
            ),
            ListTile(
              title: 'Restaurants'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.RESTAURANTS);
              },
            ),
            ListTile(
              title: 'Review Restaurants'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REVIEW_RESTAURANT);
              },
            ),
            ListTile(
              title: 'Review Food'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REVIEW_FOOD);
              },
            ),
            ListTile(
              title: 'Doctors'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.DOCTORS);
              },
            ),
            ListTile(
              title: 'Review Doctors'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REVIEW_HEALTH);
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
            /*ListTile(
              title: 'Songs'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.SONGS);
              },
            ),*/
            ListTile(
              title: 'Reports'.text,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.REPORTS);
              },
            ),
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
          onRefresh: controller.getStatistics,
          child: ListView(
            children: [
              ...controller.statistics.entries
                  .map((e) => InkWell(
                      onTap: () =>
                          controller.statistics.entries.first.key == e.key
                              ? Get.toNamed(Routes.USERS)
                              : null,
                      child: _buildStatisticItem(e.key, e.value)))
                  .toList(),
              InkWell(
                onTap: () => Get.toNamed(Routes.MONTHLY_CONTEST),
                child: _buildStatisticItem(
                  'Monthly Contest',
                  0,
                  showNumber: false,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.COMPLAINTS),
                child: _buildStatisticItem(
                  'Complaints',
                  0,
                  showNumber: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticItem(String label, int value,
      {bool showNumber = true}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label.text.bold.size(16).color(Colors.red),
            if (showNumber) value.toString().text.size(16)
          ],
        ),
      ),
    );
  }
}
