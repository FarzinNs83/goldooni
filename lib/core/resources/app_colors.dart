import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color scaffoldBackgroundColor = Color(0xFFEDF2ED);
  static const Color primaryColor = Color(0xFF658765);
  static const Color secondaryColor = Color(0xFF375437);
  static const Color teriaryColor = Color(0xFFBED4BE);
  static const Color fourthColor = Color(0xFFE1EDE1);
  static const Color fifthColor = Color(0xFF375437);
  static const Color neturalColor = Color(0xFF6C6F93);
  static const Color neturalColor8 = Color(0xFF32344B);
  static const Color neturalColor5 = Color(0xFF9496B8);
  static const Color neturalColor4 = Color(0xFFB3B5CC);
  static const Color neturalColor3 = Color(0xFFCFD0E2);
  static const Color shadowColor = Color(0xFF414A53);
  static const Color starColor = Color(0xFFFFA500);
  static const Color white = Color(0xFFFFFFFF);

  // Dark palette
  static const Color darkBackgroundColor = Color(0xFF111711);
  static const Color darkSurfaceColor = Color(0xFF1B261B);
  static const Color darkSurfaceVariant = Color(0xFF273727);
  static const Color darkPrimaryColor = Color(0xFF89C389);
  static const Color darkSecondaryColor = Color(0xFFA8C0A8);
  static const Color darkTertiaryColor = Color(0xFF2E3C2E);
  static const Color darkOnSurface = Color(0xFFE5EEE5);
  static const Color darkShadow = Color(0xFF000000);
}

class AppColorSchemes {
  const AppColorSchemes._();

  static final ColorScheme light = ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: AppColors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: AppColors.white,
    surface: AppColors.scaffoldBackgroundColor,
    onSurface: AppColors.neturalColor8,
    tertiary: AppColors.teriaryColor,
    onTertiary: AppColors.secondaryColor,
  ).copyWith(
    surfaceContainerHighest: AppColors.fourthColor,
    onSurfaceVariant: AppColors.neturalColor,
    outline: AppColors.neturalColor4,
    outlineVariant: AppColors.neturalColor3,
    shadow: AppColors.shadowColor,
    surfaceTint: AppColors.primaryColor,
  );

  static final ColorScheme dark = ColorScheme.fromSeed(
    seedColor: AppColors.darkPrimaryColor,
    brightness: Brightness.dark,
    primary: AppColors.darkPrimaryColor,
    onPrimary: AppColors.darkOnSurface,
    secondary: AppColors.darkSecondaryColor,
    onSecondary: AppColors.darkOnSurface,
    surface: AppColors.darkSurfaceColor,
    onSurface: AppColors.darkOnSurface,
    tertiary: AppColors.darkTertiaryColor,
    onTertiary: AppColors.darkOnSurface,
  ).copyWith(
    surfaceContainerHighest: AppColors.darkSurfaceVariant,
    onSurfaceVariant: AppColors.darkOnSurface.withValues(alpha: .8),
    outline: AppColors.darkOnSurface.withValues(alpha: .35),
    outlineVariant: AppColors.darkOnSurface.withValues(alpha: .2),
    shadow: AppColors.darkShadow,
    surfaceTint: AppColors.darkPrimaryColor,
  );
}
