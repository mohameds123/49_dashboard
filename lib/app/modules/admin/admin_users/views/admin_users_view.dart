import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourtynine_dashboard/app/modules/admin/admin_users/views/all_users_view.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/helper/infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import '../../../../core/helper/infinite_scroll_pagination/src/ui/paged_list_view.dart';
import '../../../../core/helper/user_search_delegate.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/base_user.dart';
import '../controllers/admin_users_controller.dart';

class AdminUsersView extends GetView<AdminUsersController> {
  const AdminUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dslf'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: UserSearchDelegate(
                  'admin/users-search',
                  (v) => controller.showNotificationDialog(userId: v.id),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body:  ListView.builder(
        itemCount: 10,
          itemBuilder: (context, index)=>AllUsersView(),
      ),
      // body: PagedListView(
      //   pagingController: controller.usersPagingController,
      //   builderDelegate: PagedChildBuilderDelegate<BaseUser>(
      //     itemBuilder: (context, item, index) => _buildUserCard(item),
      //   ),
      // ),
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

  Widget _buildUserCard(BaseUser user) {
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
            SizedBox(height: 15),
            user.phone.text.bold.size(14).color(Colors.red),
            SizedBox(height: 5),
            Row(
              children: [
                IconButton(
                  onPressed: () =>
                      controller.showNotificationDialog(userId: user.id),
                  icon: Icon(
                    Icons.notifications_none,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
