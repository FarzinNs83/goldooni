import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goldooni/core/resources/app_colors.dart';
import 'package:goldooni/core/resources/app_text_theme.dart';
import 'package:goldooni/gen/fonts.gen.dart';

class AppTheme {
  AppTheme._();

  static SystemUiOverlayStyle get lightOverlay => SystemUiOverlayStyle(
        statusBarColor: AppColorSchemes.light.surface,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColorSchemes.light.surface,
        systemNavigationBarIconBrightness: Brightness.dark,
      );

  static SystemUiOverlayStyle get darkOverlay => SystemUiOverlayStyle(
        statusBarColor: AppColorSchemes.dark.surface,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColorSchemes.dark.surface,
        systemNavigationBarIconBrightness: Brightness.light,
      );

  static ThemeData get lightTheme => _theme(AppColorSchemes.light);

  static ThemeData get darkTheme => _theme(AppColorSchemes.dark);

  static ThemeData _theme(ColorScheme colors) {
    final textTheme = colors.brightness == Brightness.dark
        ? AppTextTheme.dark(colors)
        : AppTextTheme.light(colors);

    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.vazirmatn,
      colorScheme: colors,
      scaffoldBackgroundColor: colors.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        elevation: 0,
        centerTitle: true,
        foregroundColor: colors.onSurface,
        titleTextStyle: textTheme.titleLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colors.onSurface.withValues(alpha: .6),
        ),
        fillColor: colors.surfaceContainerHighest,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          textStyle: textTheme.labelMedium,
        ),
      ),
      chipTheme: ChipThemeData(
        labelStyle: textTheme.bodySmall,
        backgroundColor: colors.surfaceContainerHighest,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: const StadiumBorder(),
      ),
      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
