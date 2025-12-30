import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTypography {
  AppTypography._();

  // Font Family
  static const String primaryFont = 'Poppins';
  static const String secondaryFont = 'Inter';
  static const String monoFont = 'RobotoMono';

  // ============ Display Styles ============
  static TextStyle displayLarge(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 57.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      height: 1.12,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle displayMedium(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 45.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.16,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle displaySmall(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 36.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.22,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  // ============ Headline Styles ============
  static TextStyle headlineLarge(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 32.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.25,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle headlineMedium(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 28.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.29,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle headlineSmall(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.33,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  // ============ Title Styles ============
  static TextStyle titleLarge(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.27,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle titleMedium(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.50,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle titleSmall(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.43,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  // ============ Body Styles ============
  static TextStyle bodyLarge(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle bodyMedium(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle bodySmall(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
      color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  // ============ Label Styles ============
  static TextStyle labelLarge(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.43,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle labelMedium(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      height: 1.33,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle labelSmall(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
      color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  // ============ Special Styles ============
  static TextStyle calorieNumber(BuildContext context) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 48.sp,
      fontWeight: FontWeight.w800,
      letterSpacing: -1,
      height: 1.0,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle nutritionValue(BuildContext context) {
    return TextStyle(
      fontFamily: monoFont,
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.2,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle badge(BuildContext context) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 10.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      height: 1.0,
      color: Colors.white,
    );
  }
}