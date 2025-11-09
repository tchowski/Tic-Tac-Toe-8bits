import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: AppFonts.pressStart2P,
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 2,
      ),
      displayMedium: TextStyle(
        fontFamily: AppFonts.pressStart2P,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 1.5,
      ),
      displaySmall: TextStyle(
        fontFamily: AppFonts.pressStart2P,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 1.5,
      ),
      headlineLarge: TextStyle(
        fontFamily: AppFonts.pressStart2P,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 1.2,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppFonts.pressStart2P,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 1,
      ),
      headlineSmall: TextStyle(
        fontFamily: AppFonts.pressStart2P,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 1,
      ),
      titleLarge: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        letterSpacing: 0.4,
      ),
      labelLarge: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        minimumSize: const Size(0, AppDimensions.buttonHeightM),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
        textStyle: const TextStyle(
          fontFamily: AppFonts.defaultFont,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(0, AppDimensions.buttonHeightM),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        side: const BorderSide(color: AppColors.primary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
        textStyle: const TextStyle(
          fontFamily: AppFonts.defaultFont,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(0, AppDimensions.buttonHeightM),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        textStyle: const TextStyle(
          fontFamily: AppFonts.defaultFont,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.defaultFont,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        letterSpacing: 1,
      ),
    );
  }
}

