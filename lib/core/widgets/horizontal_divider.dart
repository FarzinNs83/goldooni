import 'package:flutter/material.dart';
import 'package:goldooni/core/utils/app_ext.dart';

class HorizDivider extends StatelessWidget {
  const HorizDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Divider(color: context.theme.colorScheme.outlineVariant),
    );
  }
}