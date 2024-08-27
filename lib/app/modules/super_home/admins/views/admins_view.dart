import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../data/model/admin_model.dart';
import '../controllers/admins_controller.dart';

class AdminsView extends GetView<AdminsController> {
  const AdminsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admins'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.admins.length,
          itemBuilder: (_, index) =>
              _buildAdminWidget(controller.admins[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: Icon(Icons.add),
        onPressed: controller.showAddAdminDialog,
      ),
    );
  }

  Widget _buildAdminWidget(AdminModel admin) {
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Name'.text,
                admin.name.text.bold.size(16),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Username'.text,
                admin.username.text.bold.size(16),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Password'.text,
                admin.password.text.bold.size(16),
              ],
            ),
            SizedBox(height: 10),
            IconButton(
                onPressed: () => controller.showDeleteAdminDialog(admin),
                icon: Icon(Icons.clear)),
          ],
        ),
      ),
    );
  }
}
