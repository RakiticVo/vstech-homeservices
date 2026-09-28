import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker Job Detail & Acceptance screen.
/// Displays transparent financial breakdown:
/// Labour (350k) + Surcharge (50k) - Platform Fee 15% (60k) = Net 340.000đ.
class WorkerJobDetailPage extends StatelessWidget {
  const WorkerJobDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.workerDashboard),
        ),
        title: Text(
          context.l10n.jobDetailTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  // Service Title & Time Card
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.l10n.jobSampleCleaningTitle,
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.secondarySurface,
                                borderRadius: BorderRadius.circular(AppRadius.chip),
                                border: Border.all(color: AppColors.primary),
                              ),
                              child: Text(
                                context.l10n.workerArriveIn20Min,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.xs,
                          children: [
                            _InfoChip(
                              icon: Icons.navigation_outlined,
                              label: context.l10n.jobDistance('2.1 km'),
                            ),
                            _InfoChip(
                              icon: Icons.access_time_rounded,
                              label: context.l10n.jobEstimatedTime('60 - 90 phút'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Customer & Location Card
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.jobCustomerName,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          context.l10n.jobSampleCustomerName,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          context.l10n.jobCustomerAddress,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                context.l10n.jobSampleCustomerAddress,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Transparent Financial Breakdown Card
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.receipt_outlined,
                              size: 20,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              context.l10n.jobPriceBreakdown,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _FeeRow(
                          label: context.l10n.jobLabourFee,
                          amount: '+ 350.000đ',
                          isPositive: true,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _FeeRow(
                          label: context.l10n.jobSiteSurcharge,
                          amount: '+ 50.000đ',
                          isPositive: true,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _FeeRow(
                          label: context.l10n.jobPlatformFee,
                          amount: '- 60.000đ',
                          isNegative: true,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const Divider(height: 1, color: AppColors.border),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.workerNetEarnings,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  context.l10n.jobNetEarningsDesc,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '340.000đ',
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Pinned Bottom Accept CTA
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.jobAcceptedSuccess),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.workerDashboard);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    context.l10n.jobAcceptCta,
                    style: AppTextStyles.buttonText.copyWith(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow({
    required this.label,
    required this.amount,
    this.isPositive = false,
    this.isNegative = false,
  });

  final String label;
  final String amount;
  final bool isPositive;
  final bool isNegative;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          amount,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isNegative
                ? AppColors.error
                : (isPositive ? AppColors.textPrimary : AppColors.textPrimary),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
