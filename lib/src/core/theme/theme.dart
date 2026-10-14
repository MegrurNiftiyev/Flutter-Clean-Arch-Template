import 'package:flutter/material.dart';
import '../../../gen/fonts.gen.dart';
import 'colors.dart';
import 'text_styles.dart';

abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.inter,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      disabledColor: AppColors.disabled,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle:
            AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        titleTextStyle:
            AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
      ),
      textTheme: TextTheme(
        displayLarge:
            AppTextStyles.displayLarge.copyWith(color: AppColors.textPrimary),
        displayMedium:
            AppTextStyles.displayMedium.copyWith(color: AppColors.textPrimary),
        titleLarge:
            AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
        titleMedium:
            AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary),
        bodyLarge:
            AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
        bodyMedium:
            AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        bodySmall: AppTextStyles.bodySmall,
        labelLarge:
            AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.inter,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primary,
      disabledColor: AppColors.disabled,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle:
            AppTextStyles.titleLarge.copyWith(color: AppColors.textLight),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        titleTextStyle:
            AppTextStyles.titleLarge.copyWith(color: AppColors.textLight),
      ),
      textTheme: TextTheme(
        displayLarge:
            AppTextStyles.displayLarge.copyWith(color: AppColors.textLight),
        displayMedium:
            AppTextStyles.displayMedium.copyWith(color: AppColors.textLight),
        titleLarge:
            AppTextStyles.titleLarge.copyWith(color: AppColors.textLight),
        titleMedium:
            AppTextStyles.titleMedium.copyWith(color: AppColors.textLight),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.textLight),
        bodyMedium:
            AppTextStyles.bodyMedium.copyWith(color: AppColors.textLight),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
        labelLarge:
            AppTextStyles.labelLarge.copyWith(color: AppColors.textLight),
      ),
    );
  }
}
