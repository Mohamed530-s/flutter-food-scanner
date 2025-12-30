// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_food_scanner/controllers/theme_controller.dart';
import 'package:ai_food_scanner/core/constants.dart';
import 'package:ai_food_scanner/widgets/glass_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

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
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      AppStrings.profile,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      // Profile picture
                      Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.secondary,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60.sp,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Text(
                        'Food Scanner User',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        'user@foodscanner.com',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),

                      SizedBox(height: 40.h),

                      // Settings section
                      Text(
                        AppStrings.settings,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      SizedBox(height: 16.h),

                      // Dark mode toggle
                      GlassCard(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                                color: AppColors.primary,
                                size: 28.sp,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Text(
                                AppStrings.darkMode,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Switch(
                              value: isDarkMode,
                              onChanged: (value) {
                                ref
                                    .read(themeModeProvider.notifier)
                                    .toggleTheme();
                              },
                              activeThumbColor: AppColors.primary,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Other settings
                      _buildSettingItem(
                        context,
                        'Notifications',
                        Icons.notifications_outlined,
                        () {},
                      ),

                      SizedBox(height: 12.h),

                      _buildSettingItem(
                        context,
                        'History',
                        Icons.history,
                        () {},
                      ),

                      SizedBox(height: 12.h),

                      _buildSettingItem(
                        context,
                        'Preferences',
                        Icons.settings,
                        () {},
                      ),

                      SizedBox(height: 40.h),

                      // About section
                      Text(
                        AppStrings.about,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      SizedBox(height: 16.h),

                      _buildSettingItem(
                        context,
                        'Help & Support',
                        Icons.help_outline,
                        () {},
                      ),

                      SizedBox(height: 12.h),

                      _buildSettingItem(
                        context,
                        'Privacy Policy',
                        Icons.privacy_tip_outlined,
                        () {},
                      ),

                      SizedBox(height: 12.h),

                      _buildSettingItem(
                        context,
                        'Terms of Service',
                        Icons.description_outlined,
                        () {},
                      ),

                      SizedBox(height: 24.h),

                      // Version
                      Text(
                        AppStrings.version,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),

                      SizedBox(height: 40.h),

                      // Logout button
                      ElevatedButton.icon(
                        onPressed: () {
                          // Logout functionality
                          context.go('/home');
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 16.h,
                          ),
                        ),
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GlassCard(
      onTap: onTap,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
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
