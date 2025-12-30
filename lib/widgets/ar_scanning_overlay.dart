// ignore_for_file: deprecated_member_use, unused_import

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetectionBox {
  final Rect rect;
  final String label;
  final double confidence;

  DetectionBox({
    required this.rect,
    required this.label,
    required this.confidence,
  });
}

class ARScanningOverlay extends StatefulWidget {
  final bool isScanning;
  final double? detectionProgress;
  final List<DetectionBox>? detections;

  const ARScanningOverlay({
    super.key,
    this.isScanning = false,
    this.detectionProgress,
    this.detections,
  });

  @override
  State<ARScanningOverlay> createState() => _ARScanningOverlayState();
}

class _ARScanningOverlayState extends State<ARScanningOverlay>
    with TickerProviderStateMixin {
  late AnimationController _scanLineController;
  late AnimationController _pulseController;
  late Animation<double> _scanLineAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _scanLineController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scanLineController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Darkened overlay
        Positioned.fill(
          child: CustomPaint(
            painter: ScanningFramePainter(
              scanProgress: widget.isScanning ? _scanLineAnimation.value : 0,
              detectionProgress: widget.detectionProgress ?? 0,
            ),
          ),
        ),

        // Corner markers with animation
        if (widget.isScanning)
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Positioned.fill(
                child: CustomPaint(
                  painter: CornerMarkersPainter(
                    pulseScale: _pulseAnimation.value,
                    color: widget.detectionProgress != null &&
                            widget.detectionProgress! > 0.5
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            },
          ),

        // Detection boxes
        if (widget.detections != null)
          ...widget.detections!.map((detection) => Positioned(
                left: detection.rect.left,
                top: detection.rect.top,
                child: _DetectionBox(detection: detection),
              )),

        // Scanning line
        if (widget.isScanning)
          AnimatedBuilder(
            animation: _scanLineAnimation,
            builder: (context, child) {
              return Positioned(
                top: 100.h + (_scanLineAnimation.value * 400.h),
                left: 40.w,
                right: 40.w,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.primary,
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

        // Instructions
        if (!widget.isScanning && (widget.detectionProgress ?? 0) == 0)
          Positioned(
            bottom: 100.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Position food within the frame',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DetectionBox extends StatelessWidget {
  final DetectionBox detection;

  const _DetectionBox({required this.detection});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: detection.rect.width,
      height: detection.rect.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.greenAccent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
          ),
          child: Text(
            '${detection.label} ${(detection.confidence * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ScanningFramePainter extends CustomPainter {
  final double scanProgress;
  final double detectionProgress;

  ScanningFramePainter({
    required this.scanProgress,
    required this.detectionProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Implementation here
  }

  @override
  bool shouldRepaint(ScanningFramePainter oldDelegate) {
    return oldDelegate.scanProgress != scanProgress ||
        oldDelegate.detectionProgress != detectionProgress;
  }
}

class CornerMarkersPainter extends CustomPainter {
  final double pulseScale;
  final Color color;

  CornerMarkersPainter({
    required this.pulseScale,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * pulseScale
      ..strokeCap = StrokeCap.round;

    final cornerLength = 30.0 * pulseScale;
    const padding = 40.0;
    final frameWidth = size.width - (padding * 2);
    final frameHeight = frameWidth * 1.2;
    final frameTop = (size.height - frameHeight) / 2;

    // Top-left
    canvas.drawLine(
      Offset(padding, frameTop + 20),
      Offset(padding, frameTop),
      paint,
    );
    canvas.drawLine(
      Offset(padding, frameTop),
      Offset(padding + cornerLength, frameTop),
      paint,
    );

    // Top-right
    canvas.drawLine(
      Offset(size.width - padding, frameTop + 20),
      Offset(size.width - padding, frameTop),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - padding, frameTop),
      Offset(size.width - padding - cornerLength, frameTop),
      paint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(padding, frameTop + frameHeight - 20),
      Offset(padding, frameTop + frameHeight),
      paint,
    );
    canvas.drawLine(
      Offset(padding, frameTop + frameHeight),
      Offset(padding + cornerLength, frameTop + frameHeight),
      paint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(size.width - padding, frameTop + frameHeight - 20),
      Offset(size.width - padding, frameTop + frameHeight),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - padding, frameTop + frameHeight),
      Offset(size.width - padding - cornerLength, frameTop + frameHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(CornerMarkersPainter oldDelegate) {
    return oldDelegate.pulseScale != pulseScale || oldDelegate.color != color;
  }
}