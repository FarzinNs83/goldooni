import 'package:flutter/material.dart';
import 'package:goldooni/core/utils/app_ext.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final TextEditingController ctrl;
  final TextDirection txtDir;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool isObsecure;
  final bool readOnly;
  final Function(String)? onChanged;
  const AppTextField({
    super.key,
    required this.hintText,
    required this.ctrl,
    this.txtDir = TextDirection.rtl,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    required this.focusNode,
    this.nextFocus,
    this.suffixIcon,
    this.readOnly = false, this.isObsecure = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: isObsecure,
      readOnly: readOnly,
      cursorColor: context.theme.colorScheme.primary,
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
