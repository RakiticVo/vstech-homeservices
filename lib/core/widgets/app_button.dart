import 'package:flutter/material.dart';

import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';

/// Shared primary CTA button. Feature pages must use this (or [AppSecondaryButton]) instead of a
/// raw [ElevatedButton]/[TextButton], per CLAUDE.md UI Component Rules.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppErgonomics.primaryCtaMinHeight,
      child: ElevatedButton(
        key: key,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onPrimary),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(label),
                ],
              ),
      ),
    );
  }
}

/// Shared secondary/outlined action button — lower emphasis than [AppButton].
class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppErgonomics.primaryCtaMinHeight,
      child: OutlinedButton(
        key: key,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
