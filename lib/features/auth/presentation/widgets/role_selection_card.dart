import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Selection card for the Role Gateway (Customer vs Worker).
/// Adheres strictly to the Eco-Clean Sanctuary v9.0 selection rule:
/// Active state = secondarySurface background + primary border + check icon.
class RoleSelectionCard extends StatelessWidget {
  const RoleSelectionCard({
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.actionText,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String iconAsset;
  final String title;
  final String description;
  final String actionText;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.surface : AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.control),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: Image.asset(
                iconAsset,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.home_repair_service_outlined,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Text column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.titleLg.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppColors.primary : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: AppColors.onPrimary,
                              )
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description,
                    style: AppTextStyles.bodyMd,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Text(
                        actionText,
                        style: AppTextStyles.labelMd.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
