import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_ext.dart';
import '../../../../gen/assets.gen.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return SearchBar(
      hintText: 'جستجو در گُل‌دونــــی',
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(
        colors.surfaceContainerHighest,
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
      ),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16.w),
      ),
      leading: SvgPicture.asset(
        Assets.svg.search,
        height: 24.r,
        width: 24.r,
        colorFilter: ColorFilter.mode(
          colors.secondary,
          BlendMode.srcIn,
        ),
      ),
      hintStyle: WidgetStateProperty.all(
        textTheme.bodyMedium?.copyWith(
          color: colors.onSurface.withValues(alpha: .6),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        textTheme.bodyMedium?.copyWith(
          color: colors.onSurface,
        ),
      ),
      trailing: [
        SvgPicture.asset(
          Assets.svg.logoMini,
          height: 28.r,
          width: 28.r,
          colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
        ),
      ],
      onTap: () {},
      onChanged: (value) {},
    );
  }
}
