import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Card notifying the worker of a new job (a PENDING booking): service, time, address and price.
class WorkerJobRequestCard extends StatelessWidget {
  const WorkerJobRequestCard({
    required this.jobTitle,
    required this.onViewAndAccept,
    this.schedule,
    this.address,
    this.price,
    this.onDecline,
    super.key,
  });

  final String jobTitle;
  final String? schedule;
  final String? address;

  /// Formatted price, e.g. "500.000đ".
  final String? price;
  final VoidCallback onViewAndAccept;

  /// Hides the offer on this device only — the API has no decline endpoint yet.
  final VoidCallback? onDecline;

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
          // Top header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: const BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.card - 1),
                topRight: Radius.circular(AppRadius.card - 1),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_active_outlined, size: 16, color: AppColors.primary),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  context.l10n.workerNewJobRequest,
                  style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
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
                if (schedule != null) _InfoLine(icon: Icons.access_time_rounded, text: schedule!),
                if (address != null) _InfoLine(icon: Icons.near_me_outlined, text: address!),
                if (price != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  const Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.l10n.bookingEstimatedPreview,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        price!,
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    if (onDecline != null) ...[
                      Expanded(
                        child: AppSecondaryButton(
                          key: const Key('worker_job_request_decline'),
                          label: context.l10n.workerDeclineJob,
                          isFullWidth: true,
                          onPressed: onDecline,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Expanded(
                      flex: 2,
                      child: AppButton.primary(
                        key: const Key('worker_job_request_accept'),
                        label: context.l10n.workerViewAndAccept,
                        onPressed: onViewAndAccept,
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

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Expanded(
            child: Text(text, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}
