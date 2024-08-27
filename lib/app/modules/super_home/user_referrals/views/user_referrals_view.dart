import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/referral_model.dart';
import '../controllers/user_referrals_controller.dart';

class UserReferralsView extends GetView<UserReferralsController> {
  const UserReferralsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.profile.fullName}\'s Referrals'),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Unique Count : '.text.size(20).bold,
                  controller.totalUnique.value.toString().text.size(20).bold,
                ],
              ),
            ),
            Expanded(
              child: PagedListView(
                pagingController: controller.usersPagingController,
                builderDelegate: PagedChildBuilderDelegate<ReferralModel>(
                  itemBuilder: (context, item, index) => _buildUserCard(item),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(ReferralModel user) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            user.fullName.text.bold.size(14).color(Colors.red),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Name'.text,
                user.fullName.text,
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Registered When'.text,
                user.timeAgo.text,
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Locked Days'.text,
                user.lockedDays.toString().text,
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => controller.showNotificationDialog(user.id),
                  icon: Icon(
                    Icons.notifications_none,
                    color: Get.theme.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () => controller.showLockDialog(user),
                  icon: Icon(
                    Icons.block,
                    color: Get.theme.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () => controller.showUnLockDialog(user),
                  icon: Icon(
                    user.lockedDays > 0 ? Icons.clear : Icons.check,
                    color: Get.theme.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: user.id),
                    );
                    CustomAlert.snackBar(
                      msg: 'The User ID has been successfully copied',
                    );
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Get.theme.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () => controller.showDeleteDialog(user),
                  icon: Icon(
                    Icons.delete_outline,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
