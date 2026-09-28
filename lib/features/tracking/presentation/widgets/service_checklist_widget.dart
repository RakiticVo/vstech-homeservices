import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Interactive or read-only 5-step standard safety checklist widget.
class ServiceChecklistWidget extends StatelessWidget {
  const ServiceChecklistWidget({
    required this.completedSteps,
    super.key,
    this.currentStep = 2,
    this.isEditable = false,
    this.onToggleStep,
  });

  /// Set of completed step indices (0 to 4).
  final Set<int> completedSteps;

  /// Index of currently active step.
  final int currentStep;

  /// Whether tapping toggles step completion (for worker).
  final bool isEditable;

  /// Callback when a step is tapped.
  final ValueChanged<int>? onToggleStep;

  @override
  Widget build(BuildContext context) {
    final stepTitles = [
      context.l10n.trackingStep1,
      context.l10n.trackingStep2,
      context.l10n.trackingStep3,
      context.l10n.trackingStep4,
      context.l10n.trackingStep5,
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.l10n.trackingServiceChecklist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '${completedSteps.length}/${stepTitles.length}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.sm),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stepTitles.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final isDone = completedSteps.contains(index);
              final isCurrent = index == currentStep && !isDone;

              return InkWell(
                onTap: isEditable ? () => onToggleStep?.call(index) : null,
                borderRadius: BorderRadius.circular(AppRadius.control),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Indicator
                      Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: isDone
                              ? AppColors.primary
                              : (isCurrent ? AppColors.secondarySurface : AppColors.surface),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDone
                                ? AppColors.primary
                                : (isCurrent ? AppColors.primary : AppColors.border),
                            width: isCurrent ? 2 : 1.5,
                          ),
                        ),
                        child: isDone
                            ? const Icon(
                                Icons.check_rounded,
                                size: 16,
                                color: AppColors.onPrimary,
                              )
                            : (isCurrent
                                ? Center(
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: AppTextStyles.labelSmall.copyWith(
                                        color: AppColors.textMuted,
                                        fontSize: 11,
                                      ),
                                    ),
                                  )),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      // Step Title & Status Badge
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stepTitles[index],
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isDone
                                    ? AppColors.textSecondary
                                    : (isCurrent ? AppColors.textPrimary : AppColors.textMuted),
                                fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                                decoration: isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isDone)
                        Text(
                          context.l10n.trackingStatusCompleted,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.successDark,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else if (isCurrent)
                        Text(
                          context.l10n.trackingStatusDoing,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
