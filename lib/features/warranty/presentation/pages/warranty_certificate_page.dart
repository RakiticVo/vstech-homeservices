import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Warranty Certificate Screen (`bhcert` — Cell 88).
///
/// Automatically issued when an order completes. Displays warranty coverage,
/// technician info, expiration period, covered/not covered terms, and QR code.
class WarrantyCertificatePage extends StatelessWidget {
  const WarrantyCertificatePage({
    super.key,
    this.orderCode = 'HS-20250318-0087',
    this.isExpired = false,
    this.hasExistingRequest = false,
  });

  final String orderCode;
  final bool isExpired;
  final bool hasExistingRequest;

  @override
  Widget build(BuildContext context) {
    final certSuffix = orderCode.length >= 4
        ? orderCode.substring(orderCode.length - 4)
        : '0087';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.customerOrders);
            }
          },
        ),
        title: Text(
          context.l10n.warrantyCertTitle,
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              children: [
                // Certificate Main Card
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              context.l10n.warrantyCertNumber(certSuffix),
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isExpired ? const Color(0xFFF1EBE0) : const Color(0xFFE3F1EA),
                              borderRadius: BorderRadius.circular(AppRadius.chip),
                            ),
                            child: Text(
                              isExpired
                                  ? context.l10n.warrantyExpiredStatus
                                  : context.l10n.warrantyActiveStatus,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isExpired ? const Color(0xFF6B7280) : const Color(0xFF047857),
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Vệ sinh & Bảo dưỡng Máy lạnh Inverter',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Divider(height: 1, color: AppColors.border),
                      const SizedBox(height: AppSpacing.sm),

                      // Rows
                      _buildInfoRow(
                        label: context.l10n.warrantyTechnicianLabel,
                        value: 'Trần Văn Hùng',
                      ),
                      _buildInfoRow(
                        label: context.l10n.warrantyCompletedLabel,
                        value: '18/03/2026',
                      ),
                      _buildInfoRow(
                        label: context.l10n.warrantyPeriodLabel,
                        value: context.l10n.warrantyPeriodValue,
                      ),
                      _buildInfoRow(
                        label: context.l10n.warrantyRemainingLabel,
                        value: isExpired
                            ? context.l10n.warrantyExpiredText
                            : context.l10n.warrantyRemainingDays,
                        valueColor: isExpired ? AppColors.textMuted : AppColors.primary,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // QR Code Box
                      Row(
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            padding: const EdgeInsets.all(AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(AppRadius.control),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const ColoredBox(
                              color: Color(0xFFF8FAFC),
                              child: Icon(
                                Icons.qr_code_2_rounded,
                                size: 70,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              context.l10n.warrantyQrNote,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Covered Section
                Text(
                  context.l10n.warrantyCoveredTitle,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _buildCoveredItem(context.l10n.warrantyCoveredItem1),
                      const SizedBox(height: AppSpacing.sm),
                      _buildCoveredItem(context.l10n.warrantyCoveredItem2),
                      const SizedBox(height: AppSpacing.sm),
                      _buildCoveredItem(context.l10n.warrantyCoveredItem3),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Not Covered Section
                Text(
                  context.l10n.warrantyNotCoveredTitle,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _buildNotCoveredItem(context.l10n.warrantyNotCoveredItem1),
                      const SizedBox(height: AppSpacing.sm),
                      _buildNotCoveredItem(context.l10n.warrantyNotCoveredItem2),
                      const SizedBox(height: AppSpacing.sm),
                      _buildNotCoveredItem(context.l10n.warrantyNotCoveredItem3),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom CTA
          if (!isExpired)
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
              child: AppButton(
                label: hasExistingRequest
                    ? context.l10n.warrantyViewRequestCta
                    : context.l10n.warrantyRequestCta,
                icon: hasExistingRequest ? Icons.visibility_outlined : Icons.build_circle_outlined,
                onPressed: () {
                  if (hasExistingRequest) {
                    unawaited(context.push(AppRoutes.warrantyStatus));
                  } else {
                    unawaited(context.push(AppRoutes.warrantyRequest));
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.labelMedium.copyWith(
                color: valueColor ?? AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoveredItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, size: 13, color: Colors.white),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotCoveredItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.error, width: 1.5),
          ),
          alignment: Alignment.center,
          child: const Text(
            '−',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.error,
              height: 1,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
