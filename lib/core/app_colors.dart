import 'package:flutter/material.dart';

class AppColors {
  // Prevent instantiation
  AppColors._();

  // ============ Light Theme Colors ============
  // Primary Colors
  static const Color primaryLight = Color(0xFF6C63FF);
  static const Color primaryContainerLight = Color(0xFFE8E6FF);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onPrimaryContainerLight = Color(0xFF21005D);

  // Secondary Colors
  static const Color secondaryLight = Color(0xFF00C9A7);
  static const Color secondaryContainerLight = Color(0xFFCCF4EC);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryContainerLight = Color(0xFF002114);

  // Tertiary Colors
  static const Color tertiaryLight = Color(0xFFFFBF00);
  static const Color tertiaryContainerLight = Color(0xFFFFEDB8);
  static const Color onTertiaryLight = Color(0xFF000000);

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFBFE);
  static const Color surfaceDimLight = Color(0xFFE3E1E6);
  static const Color surfaceBrightLight = Color(0xFFFFFBFE);
  static const Color surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowLight = Color(0xFFF8F9FD);
  static const Color surfaceContainerLight = Color(0xFFF3F4F9);
  static const Color surfaceContainerHighLight = Color(0xFFEDEEF3);
  static const Color surfaceContainerHighestLight = Color(0xFFE7E8ED);

  // Background
  static const Color backgroundLight = Color(0xFFF8F9FD);
  static const Color onBackgroundLight = Color(0xFF1A1A1A);

  // Error Colors
  static const Color errorLight = Color(0xFFBA1A1A);
  static const Color errorContainerLight = Color(0xFFFFDAD6);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color onErrorContainerLight = Color(0xFF410002);

  // Success Colors
  static const Color successLight = Color(0xFF00C853);
  static const Color successContainerLight = Color(0xFFB7F4D0);

  // Warning Colors
  static const Color warningLight = Color(0xFFFFBF00);
  static const Color warningContainerLight = Color(0xFFFFEDB8);

  // ============ Dark Theme Colors ============
  // Primary Colors
  static const Color primaryDark = Color(0xFFB8B5FF);
  static const Color primaryContainerDark = Color(0xFF4A47A8);
  static const Color onPrimaryDark = Color(0xFF36008D);
  static const Color onPrimaryContainerDark = Color(0xFFE8E6FF);

  // Secondary Colors
  static const Color secondaryDark = Color(0xFF80E8CE);
  static const Color secondaryContainerDark = Color(0xFF005741);
  static const Color onSecondaryDark = Color(0xFF003829);
  static const Color onSecondaryContainerDark = Color(0xFFCCF4EC);

  // Tertiary Colors
  static const Color tertiaryDark = Color(0xFFFFD54F);
  static const Color tertiaryContainerDark = Color(0xFFCC8F00);
  static const Color onTertiaryDark = Color(0xFF3E2E00);

  // Surface Colors
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceDimDark = Color(0xFF1A1A1A);
  static const Color surfaceBrightDark = Color(0xFF413F47);
  static const Color surfaceContainerLowestDark = Color(0xFF0F0E11);
  static const Color surfaceContainerLowDark = Color(0xFF1D1B20);
  static const Color surfaceContainerDark = Color(0xFF2A2A2A);
  static const Color surfaceContainerHighDark = Color(0xFF36343B);
  static const Color surfaceContainerHighestDark = Color(0xFF413F47);

  // Background
  static const Color backgroundDark = Color(0xFF121212);
  static const Color onBackgroundDark = Color(0xFFE8E6EA);

  // Error Colors
  static const Color errorDark = Color(0xFFFFB4AB);
  static const Color errorContainerDark = Color(0xFF93000A);
  static const Color onErrorDark = Color(0xFF690005);
  static const Color onErrorContainerDark = Color(0xFFFFDAD6);

  // Success Colors
  static const Color successDark = Color(0xFF69F0AE);
  static const Color successContainerDark = Color(0xFF005741);

  // Warning Colors
  static const Color warningDark = Color(0xFFFFD54F);
  static const Color warningContainerDark = Color(0xFFCC8F00);

  // ============ Semantic Colors ============
  // Nutrition Colors
  static const Color proteinColor = Color(0xFFE91E63); // Pink
  static const Color carbsColor = Color(0xFFFFBF00); // Amber
  static const Color fatColor = Color(0xFFFF5722); // Deep Orange
  static const Color fiberColor = Color(0xFF4CAF50); // Green
  static const Color caloriesColor = Color(0xFF6C63FF); // Primary Purple

  // Food Category Colors
  static const Color vegetablesColor = Color(0xFF4CAF50);
  static const Color fruitsColor = Color(0xFFFF6B6B);
  static const Color meatsColor = Color(0xFFD32F2F);
  static const Color dairyColor = Color(0xFF42A5F5);
  static const Color grainsColor = Color(0xFFFFB74D);
  static const Color dessertsColor = Color(0xFFBA68C8);

  // Status Colors
  static const Color highCalorie = Color(0xFFFF5252);
  static const Color mediumCalorie = Color(0xFFFFBF00);
  static const Color lowCalorie = Color(0xFF4CAF50);

  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF5A52D5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF00C9A7), Color(0xFF00B894)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF00C853), Color(0xFF00E676)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient scanningGradient = LinearGradient(
    colors: [
      Color(0xFF6C63FF),
      Color(0xFF00C9A7),
      Color(0xFFFFBF00),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}