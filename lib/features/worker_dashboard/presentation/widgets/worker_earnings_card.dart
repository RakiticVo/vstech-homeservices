import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Deep Teal card displaying worker's daily earnings and 3 key performance metrics.
/// Designed for high outdoor sunlight readability with Deep Teal (#0E5952) and crisp white typography.
class WorkerEarningsCard extends StatelessWidget {
  const WorkerEarningsCard({
    super.key,
    this.netEarnings = '340.000đ',
    this.completedJobs = '1/3',
    this.rating = '4.9 ★',
    this.acceptRate = '96%',
  });

  final String netEarnings;
  final String completedJobs;
  final String rating;
  final String acceptRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.workerTeal,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.workerTodayEarnings,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Text(
                  context.l10n.workerNetEarnings,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            netEarnings,
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 34,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.control),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _MetricColumn(
                    value: completedJobs,
                    label: context.l10n.workerCompletedJobs,
                  ),
                ),
                Container(
                  width: 1,
                  height: 28,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                Expanded(
                  child: _MetricColumn(
                    value: rating,
                    label: context.l10n.workerRating,
                  ),
                ),
                Container(
                  width: 1,
                  height: 28,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                Expanded(
                  child: _MetricColumn(
                    value: acceptRate,
                    label: context.l10n.workerAcceptRate,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  const _MetricColumn({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.secondary.withValues(alpha: 0.9),
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
