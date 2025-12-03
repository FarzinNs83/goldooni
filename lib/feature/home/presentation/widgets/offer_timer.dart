import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';

class OfferTimer extends StatelessWidget {
  final String time;
  const OfferTimer({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    return Container(
      height: 0.04.sh,
      width: 0.04.sh,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          time,
          style: context.textTheme.labelMedium?.copyWith(
            color: colors.onSurface,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
