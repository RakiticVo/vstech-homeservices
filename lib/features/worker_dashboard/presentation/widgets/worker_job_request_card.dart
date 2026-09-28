import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Card notifying worker of an incoming dispatched job with transparent payout and arrival requirement.
class WorkerJobRequestCard extends StatelessWidget {
  const WorkerJobRequestCard({
    required this.onViewAndAccept,
    this.onDecline,
    this.jobTitle = 'Dọn dẹp căn hộ 70m²',
    this.distance = '2.1 km',
    this.location = 'Thảo Điền, TP. Thủ Đức',
    this.netPayout = '340.000đ',
    super.key,
  });

  final VoidCallback onViewAndAccept;
  final VoidCallback? onDecline;
  final String jobTitle;
  final String distance;
  final String location;
  final String netPayout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.35), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top urgency header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: const BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.card - 1),
                topRight: Radius.circular(AppRadius.card - 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      context.l10n.workerNewJobRequest,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer_outlined, size: 14, color: AppColors.warning),
                      const SizedBox(width: 4),
                      Text(
                        context.l10n.workerArriveIn20Min,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(
                      Icons.near_me_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$distance • $location',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.md),

                // Financial net line
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.workerNetEarnings,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      netPayout,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Actions
                Row(
                  children: [
                    if (onDecline != null) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onDecline,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textSecondary,
                            side: const BorderSide(color: AppColors.border),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.control),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            context.l10n.workerDeclineJob,
                            style: AppTextStyles.buttonText.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: onViewAndAccept,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.control),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          context.l10n.workerViewAndAccept,
                          style: AppTextStyles.buttonText.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
