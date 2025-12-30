import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ai_food_scanner/core/constants.dart';

class AnimatedCalorieCounter extends StatefulWidget {
  final double calories;
  final Duration duration;
  final TextStyle? textStyle;

  const AnimatedCalorieCounter({
    required this.calories,
    super.key,
    this.duration = const Duration(seconds: 2),
    this.textStyle,
  });

  @override
  State<AnimatedCalorieCounter> createState() => _AnimatedCalorieCounterState();
}

class _AnimatedCalorieCounterState extends State<AnimatedCalorieCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.calories,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCalorieCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.calories != widget.calories) {
      _animation = Tween<double>(
        begin: oldWidget.calories,
        end: widget.calories,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value.toStringAsFixed(0)} kcal',
          style: widget.textStyle ??
              TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        );
      },
    );
  }
}
