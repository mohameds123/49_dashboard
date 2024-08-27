import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomTextFieldWithBackground extends StatelessWidget {
  final TextEditingController? controller;
  final Color borderColors;
  final TextInputType? textInputType;
  final String? label;
  final String? initValue;
  final bool enable;
  final double height;
  final double width;
  final bool secure;
  final ValueChanged<String>? onChange;
  final int maxLines;

  final ValueChanged<String>? onSubmit;

  const CustomTextFieldWithBackground({
    super.key,
    this.controller,
    this.textInputType,
    this.label,
    this.borderColors = Colors.white,
    this.initValue,
    this.enable = true,
    this.height = 60,
    this.width = double.infinity,
    this.secure = false,
    this.onChange,
    this.maxLines = 1,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        maxLines: maxLines,
        onChanged: onChange,
        obscureText: secure,
        initialValue: initValue,
        enabled: enable,
        keyboardType: textInputType,
        onFieldSubmitted: onSubmit,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.w700
          ),
          fillColor: Color.fromRGBO(253, 253, 255, 1),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:Get.theme.primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16)
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          enabledBorder:OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(237, 237, 237, 1),
                width: 1,

              ),
              borderRadius: BorderRadius.circular(16)

          ),
          disabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
