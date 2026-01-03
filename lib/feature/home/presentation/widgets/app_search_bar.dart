import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_ext.dart';
import '../../../../gen/assets.gen.dart';
import '../screens/search_screen.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SearchPage()),
        );
      },
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.svg.search,
              height: 24.r,
              width: 24.r,
              colorFilter: ColorFilter.mode(
                colors.secondary,
                BlendMode.srcIn,
              ),
            ),
            12.width,
            Text(
              'جستجو در گُل‌دونــــی',
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onSurface.withValues(alpha: .6),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              Assets.svg.logoMini,
              height: 28.r,
              width: 28.r,
              colorFilter: ColorFilter.mode(
                colors.primary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
