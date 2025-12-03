

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';

import '../../../../gen/assets.gen.dart';

class ProfileItems extends StatelessWidget {
  final String title;
  final String icon;
  const ProfileItems({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
        ),
        8.width,
        Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            color: colors.onSurface,
          ),
        ),
        Spacer(),
        SvgPicture.asset(
          Assets.svg.arrowLeft,
          colorFilter: ColorFilter.mode(colors.onSurface, BlendMode.srcIn),
        ),
      ],
    );
  }
}
