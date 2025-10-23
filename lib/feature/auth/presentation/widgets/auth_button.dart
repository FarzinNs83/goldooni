import 'package:flutter/material.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../gen/fonts.gen.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const AuthButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: FontFamily.vazirmatn,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.white,
        ),
      ),
    );
  }
}
