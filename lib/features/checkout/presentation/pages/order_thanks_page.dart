import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Service Completion & Thank You Screen (`thanks` — Concept 02: Cell 59).
/// Warm celebration, automatic 30-day warranty guarantee, and return to customer home.
class OrderThanksPage extends StatelessWidget {
  const OrderThanksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Eco Leaf Celebration Circle
              Container(
                width: 88,
                height: 88,
                decoration: const BoxDecoration(
                  color: AppColors.secondarySurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: AppColors.primary,
                  size: 54,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                context.l10n.thanksTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                context.l10n.thanksSubtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // 30-Day Automatic Warranty Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.secondarySurface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.shield_outlined, color: AppColors.primary),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.bookingWarranty30DaysBadge,
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            context.l10n.inspectWarrantyNotice,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Primary CTA: Back to Home
              AppButton(
                label: context.l10n.thanksBackHome,
                onPressed: () {
                  unawaited(context.push(AppRoutes.customerHome));
                },
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
