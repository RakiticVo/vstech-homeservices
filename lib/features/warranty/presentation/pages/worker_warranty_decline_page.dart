import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker Warranty Decline Screen (`wbhno` — Cell 93).
///
/// Warning of 120.000đ deduction penalty from earnings wallet, reason selection,
/// explicit acknowledgment checkbox, and red-outline confirmation CTA.
class WorkerWarrantyDeclinePage extends StatefulWidget {
  const WorkerWarrantyDeclinePage({super.key});

  @override
  State<WorkerWarrantyDeclinePage> createState() => _WorkerWarrantyDeclinePageState();
}

class _WorkerWarrantyDeclinePageState extends State<WorkerWarrantyDeclinePage> {
  int? _selectedReasonIndex;
  bool _isAcknowledged = false;

  bool get _canConfirm => _selectedReasonIndex != null && _isAcknowledged;

  @override
  Widget build(BuildContext context) {
    final reasons = [
      context.l10n.workerWarrantyReason1,
      context.l10n.workerWarrantyReason2,
      context.l10n.workerWarrantyReason3,
      context.l10n.workerWarrantyReason4,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.workerWarrantyDeclineTitle,
          style: GoogleFonts.sourceSans3(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // Warning Alert Box
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDE8E4),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: const Color(0xFFFCA5A5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Color(0xFFB91C1C), size: 22),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              context.l10n.workerWarrantyPenaltyWarnTitle,
                              style: AppTextStyles.labelMedium.copyWith(
                                color: const Color(0xFFB91C1C),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.workerWarrantyPenaltyWarnBody,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Reason Selection Header
                Text(
                  context.l10n.workerWarrantyReasonTitle,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Reason Radio Tiles
                for (int i = 0; i < reasons.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _buildReasonOption(
                      index: i,
                      label: reasons[i],
                      isSelected: _selectedReasonIndex == i,
                    ),
                  ),

                const SizedBox(height: AppSpacing.md),

                // Acknowledgment Checkbox
                InkWell(
                  onTap: () {
                    setState(() {
                      _isAcknowledged = !_isAcknowledged;
                    });
                  },
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: _isAcknowledged ? AppColors.primary : AppColors.surface,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _isAcknowledged ? AppColors.primary : AppColors.border,
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _isAcknowledged
                              ? const Icon(Icons.check, size: 14, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            context.l10n.workerWarrantyPenaltyAck,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: _canConfirm
                        ? () {
                            context.go(AppRoutes.workerJobsHub);
                          }
                        : null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _canConfirm ? const Color(0xFFB91C1C) : AppColors.border,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.control),
                      ),
                    ),
                    child: Text(
                      context.l10n.workerWarrantyConfirmDeclineCta,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: _canConfirm ? const Color(0xFFB91C1C) : AppColors.textMuted,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    context.l10n.workerWarrantyBackToJobCta,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonOption({
    required int index,
    required String label,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedReasonIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
