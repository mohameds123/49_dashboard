import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/widget/custom_text_field_with_background.dart';
import '../controllers/change_user_name_and_pass_controller.dart';


class ChangeUserNameAndPassView extends GetView<ChangeUserNameAndPassController> {
  const ChangeUserNameAndPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              SvgPicture.asset('assets/images/logo_svg.svg'),
              SizedBox(height: 20),
              CustomTextFieldWithBackground(
                label: 'Username',
                onChange: (v)=> controller.username = v,
                width: double.infinity,
              ),
              SizedBox(height: 20),

              MaterialButton(
                onPressed: controller.changeUserName,
                child: 'Update User Name'.text,
                color: Get.theme.primaryColor,
                textColor: Colors.white,
                minWidth: double.infinity,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              CustomTextFieldWithBackground(
                label: 'Current Password',
                secure: true,
                onChange: (v)=> controller.currentPassword = v,
                width: double.infinity,
              ),
              SizedBox(height: 20),

              CustomTextFieldWithBackground(
                label: 'New Password',
                secure: true,
                onChange: (v)=> controller.newPassword = v,
                width: double.infinity,
              ),
              SizedBox(height: 20),

              CustomTextFieldWithBackground(
                label: 'Confirm Password',
                secure: true,
                onChange: (v)=> controller.confirmNewPassword = v,
                width: double.infinity,
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: controller.changePassword,
                child: 'Update Password'.text,
                color: Get.theme.primaryColor,
                textColor: Colors.white,
                minWidth: double.infinity,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
