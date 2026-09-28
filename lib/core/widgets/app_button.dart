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
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  });

  const AppButton.primary({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = backgroundColor != null
        ? ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor ?? AppColors.onPrimary,
          )
        : null;

    final content = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onPrimary),
          )
        : Row(
            mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textColor != null ? TextStyle(color: textColor) : null,
                ),
              ),
            ],
          );

    return SizedBox(
      height: AppErgonomics.primaryCtaMinHeight,
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: isLoading ? null : onPressed,
        child: content,
      ),
    );
  }
}

/// Shared secondary/outlined action button — lower emphasis than [AppButton].
class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final style = OutlinedButton.styleFrom(
      backgroundColor: backgroundColor,
      side: borderColor != null ? BorderSide(color: borderColor!) : null,
      foregroundColor: textColor,
    );

    return SizedBox(
      height: AppErgonomics.primaryCtaMinHeight,
      width: isFullWidth ? double.infinity : null,
      child: OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: Row(
          mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: AppSpacing.sm),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textColor != null ? TextStyle(color: textColor) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
