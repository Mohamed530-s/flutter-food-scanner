// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ai_food_scanner/core/constants.dart';

class SegmentedImage extends StatefulWidget {
  final String imagePath;
  final List<SegmentationMask>? masks;
  final bool showOverlay;

  const SegmentedImage({
    required this.imagePath,
    super.key,
    this.masks,
    this.showOverlay = true,
  });

  @override
  State<SegmentedImage> createState() => _SegmentedImageState();
}

class _SegmentedImageState extends State<SegmentedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.longAnimationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        children: [
          // Original image
          Image.file(
            File(widget.imagePath),
            width: double.infinity,
            height: 300.h,
            fit: BoxFit.cover,
          ),

          // Segmentation overlay
          if (widget.showOverlay && widget.masks != null)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: CustomPaint(
                    size: Size(double.infinity, 300.h),
                    painter: SegmentationPainter(
                      masks: widget.masks!,
                      opacity: _animation.value,
                    ),
                  ),
                );
              },
            ),

          // Gradient overlay for better text readability
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SegmentationMask {
  final List<Offset> points;
  final Color color;
  final String label;

  SegmentationMask({
    required this.points,
    required this.color,
    required this.label,
  });
}

class SegmentationPainter extends CustomPainter {
  final List<SegmentationMask> masks;
  final double opacity;

  SegmentationPainter({
    required this.masks,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final mask in masks) {
      final paint = Paint()
        ..color = mask.color.withOpacity(0.3 * opacity)
        ..style = PaintingStyle.fill
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 2);

      final path = Path();
      if (mask.points.isNotEmpty) {
        path.moveTo(mask.points.first.dx * size.width,
            mask.points.first.dy * size.height);
        for (var i = 1; i < mask.points.length; i++) {
          path.lineTo(
              mask.points[i].dx * size.width, mask.points[i].dy * size.height);
        }
        path.close();
      }

      canvas.drawPath(path, paint);

      // Draw border
      final borderPaint = Paint()
        ..color = mask.color.withOpacity(0.8 * opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(SegmentationPainter oldDelegate) {
    return oldDelegate.opacity != opacity || oldDelegate.masks != masks;
  }
}
