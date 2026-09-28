import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Worker withdrawal request status timeline screen (Cell 122 `wwdst`).
class WorkerWithdrawStatusPage extends StatelessWidget {
  const WorkerWithdrawStatusPage({
    super.key,
    this.withdrawalAmount,
  });

  final String? withdrawalAmount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final amount = withdrawalAmount ?? '2.000.000đ';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(AppRoutes.workerWallet),
        ),
        title: Text(
          l10n.wwdstTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    // Success icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.primary,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Success title
                    Text(
                      l10n.wwdstSuccessTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Amount display
                    Text(
                      amount,
                      style: AppTextStyles.displaySm.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Vietcombank ••• 4821',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // 3-step Timeline Card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTimelineStep(
                            isFirst: true,
                            isCompleted: true,
                            stepNumber: '1',
                            title: l10n.wwdstStep1,
                            subtitle: '16:50 · 25/04/2026',
                          ),
                          _buildTimelineStep(
                            isInProgress: true,
                            stepNumber: '2',
                            title: l10n.wwdstStep2,
                            subtitle: l10n.wwdPhase1Notice,
                          ),
                          _buildTimelineStep(
                            isLast: true,
                            stepNumber: '3',
                            title: l10n.wwdstStep3,
                            subtitle: 'Dự kiến hoàn tất trước 16:50 ngày mai',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Notice note box
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              l10n.wwdstNote,
                              style: AppTextStyles.bodySm.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: AppButton(
                label: l10n.wwdstBackWalletCta,
                onPressed: () => context.go(AppRoutes.workerWallet),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required String stepNumber,
    required String title,
    required String subtitle,
    bool isFirst = false,
    bool isLast = false,
    bool isCompleted = false,
    bool isInProgress = false,
  }) {
    final circleBg = isCompleted || isInProgress
        ? AppColors.primary
        : AppColors.surface;
    final circleText = isCompleted || isInProgress
        ? AppColors.onPrimary
        : AppColors.textMuted;
    final circleBorder = isCompleted || isInProgress
        ? AppColors.primary
        : AppColors.border;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: circleBg,
                shape: BoxShape.circle,
                border: Border.all(color: circleBorder, width: 2),
              ),
              alignment: Alignment.center,
              child: isCompleted
                  ? const Icon(Icons.check, size: 16, color: AppColors.onPrimary)
                  : Text(
                      stepNumber,
                      style: AppTextStyles.caption.copyWith(
                        color: circleText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 48,
                color: isCompleted ? AppColors.primary : AppColors.border,
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMd.copyWith(
                    fontWeight: isInProgress || isCompleted
                        ? FontWeight.w700
                        : FontWeight.w600,
                    color: isInProgress || isCompleted
                        ? AppColors.textPrimary
                        : AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySm.copyWith(
                    color: isInProgress
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
