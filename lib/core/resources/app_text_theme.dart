import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/gen/fonts.gen.dart';

class AppTextTheme {
  const AppTextTheme._();

  static TextTheme light(ColorScheme colors) =>
      _baseTextTheme(colors.onSurface, colors);

  static TextTheme dark(ColorScheme colors) =>
      _baseTextTheme(colors.onSurface, colors);

  static TextTheme _baseTextTheme(Color baseColor, ColorScheme colors) {
    final defaultStyle = TextStyle(
      fontFamily: FontFamily.vazirmatn,
      color: baseColor,
      height: 1.4,
    );

    return TextTheme(
      displayLarge: defaultStyle.copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: defaultStyle.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: defaultStyle.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: defaultStyle.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: defaultStyle.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: defaultStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: defaultStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: defaultStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: defaultStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: defaultStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: defaultStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: defaultStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: defaultStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

