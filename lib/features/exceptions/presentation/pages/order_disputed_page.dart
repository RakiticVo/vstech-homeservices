import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Order Disputed Page (Concept 02 — Cell 80 `disputed` — Order Status 7)
/// Informs the customer that their dispute has been received, money is securely frozen in Escrow,
/// and resolution is in progress within 24 hours.
class OrderDisputedPage extends StatelessWidget {
  const OrderDisputedPage({
    super.key,
    this.complaintCode = '#KN-0425-031',
    this.orderCode = 'HS-2026-0012',
  });

  final String complaintCode;
  final String orderCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.disputedStatusTitle,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),

              // Shield Icon with primary teal styling
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondarySurface,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: const Icon(Icons.security_rounded, color: AppColors.primary, size: 40),
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                context.l10n.disputedStatusTitle,
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.disputedComplaintCode(complaintCode),
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.complaintDetailOrderCode(orderCode),
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Escrow Protection Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_rounded, size: 16, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        context.l10n.disputedEscrowBadge,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Resolution Process Timeline Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.disputedTimelineTitle,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildStepRow(1, context.l10n.disputedStep1, isCompleted: true),
                    const SizedBox(height: AppSpacing.md),
                    _buildStepRow(2, context.l10n.disputedStep2, isActive: true),
                    const SizedBox(height: AppSpacing.md),
                    _buildStepRow(3, context.l10n.disputedStep3),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // View Complaints List CTA
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    unawaited(context.push(AppRoutes.customerDisputeList));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.disputedViewComplaintsBtn,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // Back to Order Detail
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    unawaited(context.push(AppRoutes.customerOrderDetail));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.disputedBackOrderBtn,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepRow(int number, String text, {bool isCompleted = false, bool isActive = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isCompleted
              ? AppColors.primary
              : (isActive ? AppColors.secondarySurface : AppColors.border),
          child: isCompleted
              ? const Icon(Icons.check, size: 14, color: AppColors.onPrimary)
              : Text(
                  '$number',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isActive ? AppColors.primary : AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: isCompleted || isActive ? AppColors.textPrimary : AppColors.textMuted,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
