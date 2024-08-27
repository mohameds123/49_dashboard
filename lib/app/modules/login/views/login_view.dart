import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../core/widget/custom_text_field_with_background.dart';
import '../controllers/login_controller.dart';
import '../../../core/widget/custom_text_field.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
              CustomTextFieldWithBackground(
                label: 'Password',
                secure: true,
                onChange: (v)=> controller.password = v,
                width: double.infinity,
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: controller.loginUser,
                child: 'Login'.text,
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
