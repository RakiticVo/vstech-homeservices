import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Card displaying promotional service offers with badges, ratings, and transparent pricing.
class ServiceOfferCard extends StatelessWidget {
  const ServiceOfferCard({
    required this.title,
    required this.description,
    required this.priceText,
    required this.tagText,
    required this.speedText,
    required this.ratingText,
    required this.iconAsset,
    required this.onTap,
    super.key,
  });

  final String title;
  final String description;
  final String priceText;
  final String tagText;
  final String speedText;
  final String ratingText;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top row: Icon and Badges
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Image.asset(
                    iconAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.cleaning_services_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      // Promo discount badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondarySurface,
                          borderRadius: BorderRadius.circular(AppRadius.chip),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Text(
                          tagText,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                      // Speed badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppRadius.chip),
                          border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          speedText,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.successDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.sm),

            // Service Title
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.titleLg.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),

            // Description
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                height: 1.3,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Bottom row: Rating & Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 14, color: AppColors.warning),
                    const SizedBox(width: 3),
                    Text(
                      ratingText,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: Text(
                    priceText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelMd.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
