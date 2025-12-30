// ignore: unused_import
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_food_scanner/core/constants.dart';
import 'package:ai_food_scanner/models/food_result.dart';
import 'package:ai_food_scanner/widgets/animated_calorie_counter.dart';
import 'package:ai_food_scanner/widgets/glass_card.dart';
import 'package:ai_food_scanner/widgets/segmented_image.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final FoodResult result;

  const ResultScreen({
    required this.result,
    super.key,
  });

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.longAnimationDuration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              // ignore: duplicate_ignore
              // ignore: deprecated_member_use
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
                    IconButton(
                      onPressed: () => context.go('/home'),
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
                          Icons.close,
                          color: AppColors.textPrimary,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    Text(
                      'Analysis Result',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    IconButton(
                      onPressed: () {
                        // Share functionality
                      },
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
                          Icons.share,
                          color: AppColors.textPrimary,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Food image with segmentation
                          SegmentedImage(
                            imagePath: widget.result.imagePath,
                            masks: widget.result.segmentationMasks,
                            showOverlay: true,
                          ),

                          SizedBox(height: 24.h),

                          // Food name
                          Text(
                            widget.result.foodName,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            'Confidence: ${(widget.result.confidence * 100).toStringAsFixed(1)}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),

                          SizedBox(height: 24.h),

                          // Calorie card
                          GlassCard(
                            child: Column(
                              children: [
                                Text(
                                  'Total Calories',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                                SizedBox(height: 12.h),
                                AnimatedCalorieCounter(
                                  calories: widget.result.calories,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Nutrition breakdown
                          Text(
                            AppStrings.nutritionInfo,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),

                          SizedBox(height: 16.h),

                          _buildNutritionCard(
                            'Protein',
                            widget.result.protein,
                            'g',
                            AppColors.primary,
                            Icons.fitness_center,
                          ),

                          SizedBox(height: 12.h),

                          _buildNutritionCard(
                            'Carbs',
                            widget.result.carbs,
                            'g',
                            AppColors.accent,
                            Icons.grain,
                          ),

                          SizedBox(height: 12.h),

                          _buildNutritionCard(
                            'Fat',
                            widget.result.fat,
                            'g',
                            AppColors.secondary,
                            Icons.water_drop,
                          ),

                          SizedBox(height: 12.h),

                          _buildNutritionCard(
                            'Fiber',
                            widget.result.fiber,
                            'g',
                            AppColors.success,
                            Icons.eco,
                          ),

                          SizedBox(height: 24.h),

                          // Recipe steps
                          if (widget.result.recipeSteps.isNotEmpty) ...[
                            Text(
                              AppStrings.recipeSteps,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            SizedBox(height: 16.h),
                            ...List.generate(
                              widget.result.recipeSteps.length,
                              (index) => _buildRecipeStep(
                                index + 1,
                                widget.result.recipeSteps[index],
                                index,
                              ),
                            ),
                          ],

                          SizedBox(height: 40.h),

                          // Action buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => context.go('/camera'),
                                  icon: const Icon(Icons.camera_alt),
                                  label: const Text('Scan Again'),
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    // Save functionality
                                  },
                                  icon: const Icon(Icons.bookmark_outline),
                                  label: const Text('Save'),
                                  style: OutlinedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    side: const BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionCard(
    String label,
    double value,
    String unit,
    Color color,
    IconData icon,
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
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${value.toStringAsFixed(1)} $unit',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ],
            ),
          ),
          // Progress indicator
          SizedBox(
            width: 50.w,
            height: 50.w,
            child: CircularProgressIndicator(
              value: (value / 100).clamp(0.0, 1.0),
              backgroundColor: color.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              strokeWidth: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeStep(int stepNumber, String step, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: GlassCard(
          padding: EdgeInsets.all(16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$stepNumber',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
