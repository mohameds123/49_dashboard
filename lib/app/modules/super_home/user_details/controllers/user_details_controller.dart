import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/custom_dio/src/custom_dio.dart';
import '../../../../core/widget/custom_alert.dart';
import '../../../../data/model/profile_model.dart';
import '../../users/controllers/users_controller.dart';

class UserDetailsController extends GetxController {
  late ProfileModel profile;

  UserDetailsController(ProfileModel profileModel) {
    profile = profileModel.copyWith();
  }

  void showSaveDialog() {
    Get.defaultDialog(
      title: 'Confirm!',
      middleText: 'are you sure you want to save changes?',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      textCancel: 'No',
      onConfirm: save,
    );
  }

  void save() async {
    try {
      Get.back();
      CustomAlert.customLoadingDialog();

      final result =
          await CustomDio().put('super-admin/users', body: profile.toMap());

      final newProfile = ProfileModel.fromMap(result.data['data']);

      final index = Get.find<UsersController>()
          .usersPagingController
          .itemList
          .indexWhere((e) => e.id == profile.id);

      if (index != -1) {
        Get.find<UsersController>()
            .usersPagingController
            .itemList
            .removeAt(index);
        Get.find<UsersController>()
            .usersPagingController
            .insertItem(index, newProfile);
      }
      Get.back();
      CustomAlert.snackBar(msg: 'Success User Edited.');
    } catch (e) {
      CustomAlert.showError(e.toString());
    }
  }
}
