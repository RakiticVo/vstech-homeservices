import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Payment Success Screen (`paid` — Concept 02: Cell 55).
/// Confirms successful payment, awards Eco-Clean loyalty points, and routes to receipt / review.
class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({
    super.key,
    this.amount = 400000,
    this.orderCode = 'HS-2026-0012',
  });

  final int amount;
  final String orderCode;

  String _formatPrice(int value) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(value)}đ';
  }

  @override
  Widget build(BuildContext context) {
    final points = amount ~/ 10000;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Success Icon Circle
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 52,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                context.l10n.paidSuccessTitle,
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.l10n.paidSuccessDesc,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Transaction Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Text(
                      _formatPrice(amount),
                      style: AppTextStyles.headlineLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      context.l10n.trackingOrderCode(orderCode),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Divider(height: 1, color: AppColors.border),
                    const SizedBox(height: AppSpacing.md),
                    // Points Reward Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.eco_rounded, color: AppColors.primary, size: 18),
                          const SizedBox(width: AppSpacing.xs),
                          Flexible(
                            child: Text(
                              context.l10n.paidPointsEarned(points),
                              style: AppTextStyles.labelSmall.copyWith(
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
              ),

              const Spacer(),

              // Primary Action: Review Worker
              AppButton(
                label: context.l10n.paidReviewWorkerCta,
                onPressed: () {
                  unawaited(
                    context.push(
                      '${AppRoutes.orderReviewTip}?amount=$amount&code=$orderCode',
                    ),
                  );
                },
              ),

              const SizedBox(height: AppSpacing.md),

              // Secondary Action: View E-Receipt
              OutlinedButton(
                onPressed: () {
                  unawaited(
                    context.push(
                      '${AppRoutes.electronicReceipt}?amount=$amount&code=$orderCode',
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.control),
                  ),
                ),
                child: Text(
                  context.l10n.paidViewReceipt,
                  style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary),
                ),
              ),

              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
