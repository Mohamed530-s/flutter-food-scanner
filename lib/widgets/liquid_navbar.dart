// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ai_food_scanner/controllers/liquid_navbar_controller.dart';
import 'package:ai_food_scanner/core/constants.dart';
import 'package:ai_food_scanner/widgets/liquid_indicator_painter.dart';

class LiquidNavBar extends ConsumerStatefulWidget {
  final Function(int) onTap;
  final List<LiquidNavBarItem> items;

  const LiquidNavBar({required this.onTap, required this.items, super.key});

  @override
  ConsumerState<LiquidNavBar> createState() => _LiquidNavBarState();
}

class _LiquidNavBarState extends ConsumerState<LiquidNavBar>
    with TickerProviderStateMixin {
  late AnimationController _indicatorController;
  late AnimationController _itemController;

  @override
  void initState() {
    super.initState();
    _indicatorController = AnimationController(
      vsync: this,
      duration: AppConstants.animationDuration,
    );
    _itemController = AnimationController(
      vsync: this,
      duration: AppConstants.animationDuration,
    );
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(liquidNavbarControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Animate indicator position when index changes
    ref.listen<LiquidNavbarState>(liquidNavbarControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.currentIndex != next.currentIndex) {
        _indicatorController.forward(from: 0);
        _itemController.forward(from: 0);
      }
    });

    final itemWidth = 1.sw / widget.items.length;

    return Container(
      height: 80.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF2A2A2A).withOpacity(0.9)
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                width: 1.5,
              ),
            ),
            child: Stack(
              children: [
                // Liquid indicator background
                AnimatedBuilder(
                  animation: _indicatorController,
                  builder: (context, child) {
                    final targetX = controller.currentIndex * itemWidth;
                    final currentX = Tween<double>(
                      begin: controller.dragStartIndex * itemWidth,
                      end: targetX,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _indicatorController,
                            curve: Curves.easeInOutCubic,
                          ),
                        )
                        .value;

                    return Positioned(
                      left: currentX,
                      top: 0,
                      child: SizedBox(
                        width: itemWidth,
                        height: 80.h,
                        child: CustomPaint(
                          painter: LiquidIndicatorPainter(
                            color: AppColors.primary.withOpacity(0.15),
                            progress: controller.isDragging ? 0.5 : 1.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Navigation items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    widget.items.length,
                    (index) => _buildNavItem(
                      index,
                      widget.items[index],
                      controller.currentIndex == index,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, LiquidNavBarItem item, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(liquidNavbarControllerProvider.notifier).setIndex(index);
          widget.onTap(index);
        },
        onPanStart: (details) {
          ref.read(liquidNavbarControllerProvider.notifier).startDrag(index);
        },
        onPanUpdate: (details) {
          final itemWidth = 1.sw / widget.items.length;
          final dragDelta = details.delta.dx;
          final currentOffset =
              ref.read(liquidNavbarControllerProvider).dragOffset;

          ref
              .read(liquidNavbarControllerProvider.notifier)
              .updateDrag(currentOffset + dragDelta);

          // Snap to nearest item if dragged far enough
          if ((currentOffset + dragDelta).abs() > itemWidth * 0.3) {
            final direction = (currentOffset + dragDelta) > 0 ? 1 : -1;
            final newIndex = (index + direction).clamp(
              0,
              widget.items.length - 1,
            );

            if (newIndex != index) {
              ref
                  .read(liquidNavbarControllerProvider.notifier)
                  .setIndex(newIndex);
              widget.onTap(newIndex);
            }
          }
        },
        onPanEnd: (details) {
          ref.read(liquidNavbarControllerProvider.notifier).endDrag();
        },
        child: AnimatedBuilder(
          animation: _itemController,
          builder: (context, child) {
            final scale = isSelected
                ? Tween<double>(begin: 1.0, end: 1.2)
                    .animate(
                      CurvedAnimation(
                        parent: _itemController,
                        curve: Curves.easeInOutBack,
                      ),
                    )
                    .value
                : 1.0;

            return Transform.scale(
              scale: scale,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    size: 28.sp,
                  ),
                  SizedBox(height: 4.h),
                  AnimatedDefaultTextStyle(
                    duration: AppConstants.animationDuration,
                    style: TextStyle(
                      fontSize: isSelected ? 12.sp : 10.sp,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    child: Text(item.label),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class LiquidNavBarItem {
  final IconData icon;
  final String label;

  const LiquidNavBarItem({required this.icon, required this.label});
}
