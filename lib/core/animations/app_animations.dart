import 'package:flutter/material.dart';

class AppAnimations {
  AppAnimations._();

  // Duration constants
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Curves
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve bounce = Curves.elasticOut;
  static const Curve spring = Curves.elasticInOut;

  // Fade animations
  static Widget fadeIn(
    Widget child, {
    Duration duration = normal,
    Curve curve = easeIn,
    Duration delay = Duration.zero,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration + delay,
      curve: curve,
      builder: (context, value, child) {
        if (delay > Duration.zero && value < delay.inMilliseconds / (duration + delay).inMilliseconds) {
          return Opacity(opacity: 0, child: child);
        }
        return Opacity(opacity: value, child: child);
      },
      child: child,
    );
  }

  // Scale animations
  static Widget scaleIn(
    Widget child, {
    Duration duration = normal,
    Curve curve = bounce,
    Duration delay = Duration.zero,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration + delay,
      curve: curve,
      builder: (context, value, child) {
        if (delay > Duration.zero && value < delay.inMilliseconds / (duration + delay).inMilliseconds) {
          return Transform.scale(scale: 0, child: child);
        }
        return Transform.scale(scale: value, child: child);
      },
      child: child,
    );
  }

  // Slide animations
  static Widget slideIn(
    Widget child, {
    Duration duration = normal,
    Curve curve = easeOut,
    Offset begin = const Offset(0, 1),
    Duration delay = Duration.zero,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: begin, end: Offset.zero),
      duration: duration + delay,
      curve: curve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value.dx * 100, value.dy * 100),
          child: child,
        );
      },
      child: child,
    );
  }

  // Shimmer effect
  static Widget shimmer(
    Widget child, {
    Duration duration = const Duration(seconds: 2),
    Color baseColor = const Color(0xFFE0E0E0),
    Color highlightColor = const Color(0xFFF5F5F5),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -1.0, end: 2.0),
      duration: duration,
      builder: (context, value, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                value - 0.3,
                value,
                value + 0.3,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: child,
    );
  }

  // Pulse animation
  static Widget pulse(
    Widget child, {
    Duration duration = const Duration(milliseconds: 1000),
    double minScale = 0.95,
    double maxScale = 1.05,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: minScale, end: maxScale),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      onEnd: () {},
      child: child,
    );
  }
}