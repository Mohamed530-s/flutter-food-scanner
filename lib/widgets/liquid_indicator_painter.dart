// ignore: unused_import
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class LiquidIndicatorPainter extends CustomPainter {
  final Color color;
  final double progress;

  LiquidIndicatorPainter({required this.color, this.progress = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final path = Path();
    final width = size.width;
    final height = size.height;

    // Create a liquid/gooey shape using bezier curves
    final waveHeight = 10 * progress;
    final centerY = height / 2;

    // Start from left
    path.moveTo(0, centerY);

    // Top wave
    path.quadraticBezierTo(
      width * 0.25,
      centerY - waveHeight,
      width * 0.5,
      centerY - waveHeight * 0.5,
    );
    path.quadraticBezierTo(width * 0.75, centerY, width, centerY);

    // Right side
    path.lineTo(width, height);

    // Bottom wave
    path.quadraticBezierTo(
      width * 0.75,
      height - waveHeight * 0.3,
      width * 0.5,
      height - waveHeight * 0.5,
    );
    path.quadraticBezierTo(
      width * 0.25,
      height - waveHeight,
      0,
      height - waveHeight * 0.5,
    );

    // Close path
    path.close();

    // Draw the liquid shape
    canvas.drawPath(path, paint);

    // Add a subtle gradient overlay for depth
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
      ).createShader(Rect.fromLTWH(0, 0, width, height))
      ..blendMode = BlendMode.overlay;

    canvas.drawPath(path, gradientPaint);
  }

  @override
  bool shouldRepaint(LiquidIndicatorPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.progress != progress;
  }
}
