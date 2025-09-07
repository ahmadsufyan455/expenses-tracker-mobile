import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Font Family
  static const String fontFamily = 'Quicksand';

  // Display Styles (Large headers)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
    color: AppColors.onBackground,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.onBackground,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.onBackground,
  );

  // Headline Styles (Medium headers)
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.onBackground,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.onBackground,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.onBackground,
  );

  // Title Styles (Small headers)
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.onBackground,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: AppColors.onBackground,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: AppColors.onBackground,
  );

  // Label Styles (Buttons, tabs)
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: AppColors.onBackground,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.onBackground,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.onBackground,
  );

  // Body Styles (Regular text)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
    color: AppColors.onBackground,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
    color: AppColors.onBackground,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
    color: AppColors.onBackground,
  );

  // Custom Expense Tracker Styles
  static const TextStyle expenseAmount = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.expenseRed,
  );

  static const TextStyle incomeAmount = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.incomeGreen,
  );

  static const TextStyle balanceAmount = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.primary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.onBackground,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: AppColors.onPrimary,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: AppColors.onPrimary,
  );

  static const TextStyle tabText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const TextStyle hintText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle errorText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
    color: AppColors.error,
  );

  // Dark theme variants
  static TextStyle get displayLargeDark =>
      displayLarge.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get displayMediumDark =>
      displayMedium.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get displaySmallDark =>
      displaySmall.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get headlineLargeDark =>
      headlineLarge.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get headlineMediumDark =>
      headlineMedium.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get headlineSmallDark =>
      headlineSmall.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get titleLargeDark =>
      titleLarge.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get titleMediumDark =>
      titleMedium.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get titleSmallDark =>
      titleSmall.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get bodyLargeDark =>
      bodyLarge.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get bodyMediumDark =>
      bodyMedium.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get bodySmallDark =>
      bodySmall.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get cardTitleDark =>
      cardTitle.copyWith(color: AppColors.onBackgroundDark);
  static TextStyle get cardSubtitleDark =>
      cardSubtitle.copyWith(color: AppColors.onSurfaceVariantDark);
  static TextStyle get hintTextDark =>
      hintText.copyWith(color: AppColors.onSurfaceVariantDark);
}
