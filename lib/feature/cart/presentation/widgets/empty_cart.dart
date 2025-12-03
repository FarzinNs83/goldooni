import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../gen/assets.gen.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    return SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.png.empty.path),
            Text(
              "سبد خرید شما خالی است",
              style: context.textTheme.titleLarge?.copyWith(
                color: colors.secondary,
              ),
            ),
            16.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  title: "مشاهده فروشگاه",
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward, color: colors.onPrimary),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
