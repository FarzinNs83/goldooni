import 'package:flutter/material.dart';
import 'package:goldooni/core/utils/app_ext.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Widget icon;
  const AppButton({super.key, required this.title, required this.onPressed, this.icon = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.theme.colorScheme;
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        spacing: 6,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textTheme.labelLarge?.copyWith(
              color: colors.onPrimary,
            ),
          ),
          icon
        ],
      ),
    );
  }
}
