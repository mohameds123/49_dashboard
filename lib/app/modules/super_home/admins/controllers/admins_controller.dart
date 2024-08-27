import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../data/model/admin_model.dart';

class AdminsController extends GetxController {
  final admins = RxList<AdminModel>();

  void getAdmins() async {
    try {
      final result = await CustomDio().get('super-admin/admins');

      admins.value = (result.data['data'] as List)
          .map((e) => AdminModel.fromMap(e))
          .toList();
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void addAdmin(String name, String username, String password) async {
    try {
      Get.back();
      final result = await CustomDio().post(
        'super-admin/admins',
        body: {'name': name, 'username': username, 'password': password},
      );
      admins.add(AdminModel.fromMap(result.data['data']));
      CustomAlert.snackBar(msg: 'Success Admin Added.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void deleteAdmin(AdminModel admin) async {
    try {
      Get.back();
      await CustomDio().delete('super-admin/admins/${admin.id}');

      admins.remove(admin);
      CustomAlert.snackBar(msg: 'Success Admin Deleted.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }

  void showDeleteAdminDialog(AdminModel admin) {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'Are you sure you want to delete Admin (${admin.name})?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () => deleteAdmin(admin),
    );
  }

  void showAddAdminDialog() {
    String name = '';
    String username = '';
    String password = '';

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFieldWithBackground(
              label: 'Name',
              onChange: (v) => name = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Username',
              onChange: (v) => username = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithBackground(
              label: 'Password',
              onChange: (v) => password = v,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child: 'Add'.text,
              color: Get.theme.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minWidth: double.infinity,
              onPressed: () => addAdmin(name, username, password),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    getAdmins();
    super.onInit();
  }
}
