// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_food_scanner/controllers/liquid_navbar_controller.dart';
import 'package:ai_food_scanner/core/constants.dart';
import 'package:ai_food_scanner/widgets/glass_card.dart';
import 'package:ai_food_scanner/widgets/liquid_navbar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(liquidNavbarControllerProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.background.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello! 👋',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'What would you like to scan?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => context.push('/profile'),
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.secondary,
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      // Scan button
                      GlassCard(
                        onTap: () => context.push('/camera'),
                        child: SizedBox(
                          height: 200.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80.w,
                                height: 80.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.secondary,
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 40.sp,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                AppStrings.scanFood,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Point your camera at any food',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // Recent scans section
                      Text(
                        AppStrings.recentScans,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 16.h),

                      // Recent scan cards
                      _buildRecentScanCard(
                        context,
                        'Pizza Margherita',
                        '450 kcal',
                        Icons.local_pizza,
                        AppColors.accent,
                      ),
                      SizedBox(height: 12.h),
                      _buildRecentScanCard(
                        context,
                        'Caesar Salad',
                        '280 kcal',
                        Icons.restaurant,
                        AppColors.success,
                      ),
                      SizedBox(height: 12.h),
                      _buildRecentScanCard(
                        context,
                        'Chocolate Cake',
                        '520 kcal',
                        Icons.cake,
                        AppColors.error,
                      ),

                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LiquidNavBar(
        onTap: (index) {
          if (index == 1) {
            context.push('/camera');
          } else if (index == 3) {
            context.push('/profile');
          }
        },
        items: const [
          LiquidNavBarItem(
            icon: Icons.home,
            label: 'Home',
          ),
          LiquidNavBarItem(
            icon: Icons.camera_alt,
            label: 'Scan',
          ),
          LiquidNavBarItem(
            icon: Icons.history,
            label: 'History',
          ),
          LiquidNavBarItem(
            icon: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildRecentScanCard(
    BuildContext context,
    String title,
    String calories,
    IconData icon,
    Color color,
  ) {
    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  calories,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}