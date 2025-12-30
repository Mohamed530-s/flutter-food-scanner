// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:ai_food_scanner/controllers/ai_controller.dart';
import 'package:ai_food_scanner/core/constants.dart';

class ProcessingScreen extends ConsumerStatefulWidget {
  final String imagePath;

  const ProcessingScreen({
    required this.imagePath,
    super.key,
  });

  @override
  ConsumerState<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends ConsumerState<ProcessingScreen> {
  @override
  void initState() {
    super.initState();
    _processImage();
  }

  Future<void> _processImage() async {
    // Process the image using AI controller
    final result = await ref
        .read(aiControllerProvider.notifier)
        .analyzeFood(widget.imagePath);

    if (mounted && result != null) {
      // Add a minimum delay for better UX
      await Future.delayed(AppConstants.processingMinDuration);

      if (mounted) {
        context.go('/result', extra: result);
      }
    } else if (mounted) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to analyze food. Please try again.'),
          backgroundColor: AppColors.error,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.8),
              AppColors.secondary.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Particle animation background
              Positioned.fill(
                child: Opacity(
                  opacity: 0.3,
                  child: Lottie.network(
                    AppConstants.particlesAnimationUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Processing animation
                    SizedBox(
                      width: 250.w,
                      height: 250.h,
                      child: Lottie.network(
                        AppConstants.processingAnimationUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Processing text
                    Text(
                      AppStrings.processing,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 16.h),

                    // Steps indicator
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Column(
                        children: [
                          _buildProcessingStep('Detecting food items', true),
                          SizedBox(height: 12.h),
                          _buildProcessingStep('Analyzing nutrition', true),
                          SizedBox(height: 12.h),
                          _buildProcessingStep('Generating recipes', false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingStep(String text, bool isActive) {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
          ),
          child: isActive
              ? Center(
                  child: SizedBox(
                    width: 12.w,
                    height: 12.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                )
              : null,
        ),
        SizedBox(width: 12.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
            fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
