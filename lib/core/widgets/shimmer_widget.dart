import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:shimmer/shimmer.dart';

/// ویجت اختصاصی برای نمایش Shimmer Loading
///
/// این ویجت از پکیج shimmer استفاده می‌کند و تمام اندازه‌ها
/// با استفاده از ScreenUtil responsive هستند.
class ShimmerWidget extends StatelessWidget {
  /// عرض ویجت
  final double? width;

  /// ارتفاع ویجت
  final double? height;

  /// شعاع گوشه‌های ویجت
  final double? borderRadius;

  /// رنگ پایه Shimmer
  final Color? baseColor;

  /// رنگ highlight Shimmer
  final Color? highlightColor;

  /// ویجت سفارشی (اگر null باشد، یک Container ساده نمایش داده می‌شود)
  final Widget? child;

  const ShimmerWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
          baseColor ??
          (Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[300]!),
      highlightColor:
          highlightColor ??
          (Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[700]!
              : Colors.grey[100]!),
      period: Duration(milliseconds: 1200),
      child:
          child ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius!)
                  : null,
            ),
          ),
    );
  }
}

class HomeCatsShimmer extends StatelessWidget {
  const HomeCatsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.14.sh,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                ShimmerWidget(width: 72.r, height: 72.r, borderRadius: 100.r),
                10.height,
                ShimmerWidget(width: 72.r, height: 14.h, borderRadius: 4.r),
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 6,
      ),
    );
  }
}
