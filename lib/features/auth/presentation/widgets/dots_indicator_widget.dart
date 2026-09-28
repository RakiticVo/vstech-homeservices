import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';

/// Clean interactive dots indicator supporting 2-way tap-to-jump navigation.
class DotsIndicatorWidget extends StatelessWidget {
  const DotsIndicatorWidget({
    required this.itemCount,
    required this.currentIndex,
    required this.onDotTapped,
    super.key,
  });

  final int itemCount;
  final int currentIndex;
  final ValueChanged<int> onDotTapped;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;
        return GestureDetector(
          onTap: () => onDotTapped(index),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: isActive ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.full),
                color: isActive ? AppColors.primary : AppColors.border,
              ),
            ),
          ),
        );
      }),
    );
  }
}
