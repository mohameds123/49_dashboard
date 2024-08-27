import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final Function()? onPressed;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autoFocus;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final Function(String?)? onSave;
  final bool enabled;
  final FocusNode? focusNode;
  final Widget? label;
  final int? maxLength;
  final int? maxLines;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomTextFormField({
    Key? key,
    this.textInputType = TextInputType.text,

    this.textEditingController,
    this.onPressed,
    this.validator,
    this.textInputAction,
    this.obscureText = false,
    this.autoFocus = false,
    this.prefix,
    this.backgroundColor,
    this.textColor,
    this.suffix,
    this.hintText,
    this.onChange,
    this.onSubmit,
    this.errorText,
    this.focusNode,
    this.enabled = true,
    this.label,
    this.onSave,
    this.maxLength,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onTap: onPressed,
      enabled: enabled,
      onSaved: onSave,
      maxLength: maxLength,
      maxLines: maxLines,
      focusNode: focusNode,
      autofocus: autoFocus,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: backgroundColor != null,
        fillColor: backgroundColor,
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headlineMedium,
        label: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: InputBorder.none,
        border: InputBorder.none,
        errorText: errorText,
      ),
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validator,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText,
    );
  }
}
