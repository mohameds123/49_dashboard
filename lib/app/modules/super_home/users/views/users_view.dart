import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/helper/user_search_super_delegate.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/profile_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => showSearch(
                    context: context,
                    delegate: UserSearchSuperDelegate(
                      'super-admin/users-search',
                      (user) =>
                          controller.showNotificationDialog(userId: user.id),
                      onBlockClick: (user) => controller.showLockDialog(user),
                      onUnBlockClick: (user) =>
                          controller.showUnLockDialog(user),
                      onDeleteClick: (user) =>
                          controller.showDeleteDialog(user),
                      onCardClick: (profile) =>
                          Get.toNamed(Routes.USER_DETAILS, arguments: profile),
                      onSubscriptionClick: (profile) =>
                          controller.showSubscribeDialog(profile),
                    ),
                  ),
              icon: Icon(Icons.search))
        ],
      ),
      body: PagedListView(
        pagingController: controller.usersPagingController,
        builderDelegate: PagedChildBuilderDelegate<ProfileModel>(
          itemBuilder: (context, item, index) => _buildUserCard(item),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.showNotificationDialog,
        backgroundColor: Get.theme.primaryColor,
        child: Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUserCard(ProfileModel profile) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.USER_DETAILS, arguments: profile),
      child: Card(
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
              profile.fullName.text.bold.size(14).color(Colors.red),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Balance'.text,
                  profile.wallet.balance.toString().text,
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Provider Cash Back'.text,
                  profile.wallet.providerCasBack.toString().text,
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Locked Days'.text,
                  profile.lockedDays.toString().text,
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Referral Count'.text,
                  profile.referralCount.toString().text,
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        controller.showNotificationDialog(userId: profile.id),
                    icon: Icon(
                      Icons.notifications_none,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.showLockDialog(profile),
                    icon: Icon(
                      Icons.block,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.showUnLockDialog(profile),
                    icon: Icon(
                      profile.isLocked ? Icons.clear : Icons.check,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: profile.id),
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
                    onPressed: () => controller.showDeleteDialog(profile),
                    icon: Icon(
                      Icons.delete_outline,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.showSubscribeDialog(profile),
                    icon: Icon(
                      Icons.card_giftcard,
                      color: Get.theme.primaryColor,
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
