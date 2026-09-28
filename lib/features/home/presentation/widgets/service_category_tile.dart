import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Single service category tile in Customer Home grid.
/// White card, 16px radius, hairline border, 48px icon container, 2-line label.
class ServiceCategoryTile extends StatelessWidget {
  const ServiceCategoryTile({
    required this.title,
    required this.iconAsset,
    required this.onTap,
    super.key,
  });

  final String title;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: Image.asset(
                iconAsset,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.handyman_outlined,
                  size: 28,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 6),

            // Two-line Title
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
