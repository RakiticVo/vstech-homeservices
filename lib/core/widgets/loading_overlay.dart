import 'package:flutter/material.dart';

import 'package:vstech_home_services/core/constants/app_colors.dart';

/// Full-screen loading overlay shown while a blocking async operation is in flight.
/// Wrap a page's body with this instead of ad hoc `Stack`/`Visibility` combinations.
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({required this.isLoading, required this.child, super.key});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          ColoredBox(
            color: AppColors.textPrimary.withValues(alpha: 0.15),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
      ],
    );
  }
}
