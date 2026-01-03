import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/feature/profile/presentation/screens/profile_screen.dart';

import '../../../../gen/assets.gen.dart';

class AuthIconButton extends StatelessWidget {
  const AuthIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    return SizedBox(
      height: 0.07.sh,
      width: 0.07.sh,
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            colors.tertiary.withValues(alpha: .4),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
          ),
        ),
        onPressed: () => context.navigateWNavBar(ProfileScreen()),
        icon: SvgPicture.asset(Assets.svg.user, height: 24.r, width: 24.r),
      ),
    );
  }
}
