import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final TextEditingController ctrl;
  final TextDirection txtDir;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  const AppTextField({
    super.key,
    required this.hintText,
    required this.ctrl,
    this.txtDir = TextDirection.rtl,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    required this.focusNode,
    this.nextFocus,
    this.suffixIcon = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.secondaryColor,
      focusNode: focusNode,
      onFieldSubmitted: (_) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        } else {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      controller: ctrl,
      textAlign: textAlign,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintTextDirection: txtDir,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
