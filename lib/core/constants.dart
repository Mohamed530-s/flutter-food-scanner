import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF00C9A7);
  static const Color accent = Color(0xFFFFBF00);
  static const Color background = Color(0xFFF8F9FD);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6A6A6A);
  
  static const Color success = Color(0xFF00C9A7);
  static const Color error = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFFBF00);
  static const Color info = Color(0xFF6C63FF);
}

class AppConstants {
  AppConstants._();

  static const String apiBaseUrl = 'http://10.0.2.2:8000'; 
  static const bool useMockService = false;
  static const String themeModeKey = 'theme_mode';
  
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration processingMinDuration = Duration(seconds: 2);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  static const String splashAnimationUrl = 'https://assets10.lottiefiles.com/packages/lf20_touohxv0.json';
  static const String particlesAnimationUrl = 'https://assets3.lottiefiles.com/packages/lf20_zyquagfl.json';
  static const String processingAnimationUrl = 'https://assets8.lottiefiles.com/packages/lf20_x62chJ.json';
}

class AppStrings {
  AppStrings._();

  static const String appName = 'AI Food Scanner';
  static const String splashTagline = 'Scan. Analyze. Eat Smart.';
  static const String scanFood = 'Scan Food';
  static const String recentScans = 'Recent Scans';
  static const String processing = 'Analyzing your food...';
  static const String nutritionInfo = 'Nutrition Information';
  static const String recipeSteps = 'Recipe Steps';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String darkMode = 'Dark Mode';
  static const String about = 'About';
  static const String version = 'Version 1.0.0';
}