import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppButtonType {
  primary,
  secondary,
  tertiary,
  outlined,
  text,
  icon,
  floating,
}

enum AppButtonSize {
  small,
  medium,
  large,
}

class AppButton extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    required this.onPressed, super.key,
    this.label,
    this.icon,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Size configuration
    double height;
    double fontSize;
    double iconSize;
    EdgeInsets buttonPadding;

    switch (widget.size) {
      case AppButtonSize.small:
        height = 36.h;
        fontSize = 12.sp;
        iconSize = 16.sp;
        buttonPadding = EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
        break;
      case AppButtonSize.large:
        height = 56.h;
        fontSize = 16.sp;
        iconSize = 24.sp;
        buttonPadding = EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h);
        break;
      case AppButtonSize.medium:
      height = 48.h;
        fontSize = 14.sp;
        iconSize = 20.sp;
        buttonPadding = EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h);
    }

    // Style configuration based on type
    Color bgColor;
    Color fgColor;
    BorderSide? border;
    double elevation;

    switch (widget.type) {
      case AppButtonType.primary:
        bgColor = widget.backgroundColor ?? theme.colorScheme.primary;
        fgColor = widget.foregroundColor ?? theme.colorScheme.onPrimary;
        border = null;
        elevation = _isPressed ? 1 : 2;
        break;
      case AppButtonType.secondary:
        bgColor =
            widget.backgroundColor ?? theme.colorScheme.secondaryContainer;
        fgColor =
            widget.foregroundColor ?? theme.colorScheme.onSecondaryContainer;
        border = null;
        elevation = _isPressed ? 0 : 1;
        break;
      case AppButtonType.tertiary:
        bgColor = widget.backgroundColor ?? theme.colorScheme.tertiaryContainer;
        fgColor =
            widget.foregroundColor ?? theme.colorScheme.onTertiaryContainer;
        border = null;
        elevation = 0;
        break;
      case AppButtonType.outlined:
        bgColor = Colors.transparent;
        fgColor = widget.foregroundColor ?? theme.colorScheme.primary;
        border = BorderSide(color: theme.colorScheme.outline, width: 1.5);
        elevation = 0;
        break;
      case AppButtonType.text:
        bgColor = Colors.transparent;
        fgColor = widget.foregroundColor ?? theme.colorScheme.primary;
        border = null;
        elevation = 0;
        break;
      case AppButtonType.icon:
        bgColor = widget.backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
        fgColor = widget.foregroundColor ?? theme.colorScheme.onSurfaceVariant;
        border = null;
        elevation = 0;
        break;
      case AppButtonType.floating:
        bgColor = widget.backgroundColor ?? theme.colorScheme.primaryContainer;
        fgColor =
            widget.foregroundColor ?? theme.colorScheme.onPrimaryContainer;
        border = null;
        elevation = _isPressed ? 4 : 6;
        break;
    }

    Widget buttonChild;
    if (widget.isLoading) {
      buttonChild = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(fgColor),
        ),
      );
    } else if (widget.child != null) {
      buttonChild = widget.child!;
    } else if (widget.icon != null && widget.label != null) {
      buttonChild = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: iconSize, color: fgColor),
          SizedBox(width: 8.w),
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: fgColor,
            ),
          ),
        ],
      );
    } else if (widget.icon != null) {
      buttonChild = Icon(widget.icon, size: iconSize, color: fgColor);
    } else {
      buttonChild = Text(
        widget.label ?? '',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: fgColor,
        ),
      );
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: widget.onPressed != null ? _handleTapDown : null,
        onTapUp: widget.onPressed != null ? _handleTapUp : null,
        onTapCancel: widget.onPressed != null ? _handleTapCancel : null,
        child: Material(
          color: bgColor,
          elevation: elevation,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              height: widget.type == AppButtonType.icon ? height : null,
              width: widget.type == AppButtonType.icon
                  ? height
                  : (widget.isFullWidth ? double.infinity : null),
              padding: widget.padding ?? buttonPadding,
              decoration: BoxDecoration(
                border: border != null ? Border.fromBorderSide(border) : null,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(child: buttonChild),
            ),
          ),
        ),
      ),
    );
  }
}