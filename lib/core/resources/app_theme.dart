import 'package:flutter/material.dart';
import 'package:goldooni/core/resources/app_colors.dart';
import 'package:goldooni/gen/fonts.gen.dart';

class AppTheme {
  AppTheme._();
  static ThemeData appTheme = ThemeData().copyWith(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.fourthColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24, vertical: 16),),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ))
        ),
        
    ),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(
        color: AppColors.neturalColor5,
        fontFamily: FontFamily.vazirmatn,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      fillColor: AppColors.fourthColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
