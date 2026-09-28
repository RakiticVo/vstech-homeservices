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

/// Worker Warranty Job Detail Screen (`wbh` — Cell 92).
///
/// Dispatched warranty task: 0đ payout, 24h countdown deadline, customer issue
/// photos, and original order details with before/after photos.
class WorkerWarrantyJobDetailPage extends StatelessWidget {
  const WorkerWarrantyJobDetailPage({
    super.key,
    this.orderCode = 'HS-20250318-0087',
  });

  final String orderCode;

  @override
  Widget build(BuildContext context) {
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
              context.go(AppRoutes.workerJobsHub);
            }
          },
        ),
        title: Text(
          context.l10n.workerWarrantyJobTitle,
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
                // Top Badges
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F1EA),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        context.l10n.warrantyBadgeTag,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: const Color(0xFF0E5952),
                          fontWeight: FontWeight.w800,
                          fontSize: 9.5,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF0D8),
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: Text(
                        context.l10n.workerWarrantyDeadline,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: const Color(0xFFA35A06),
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                // Job Summary Card
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
                      Text(
                        'Vệ sinh & Bảo dưỡng Máy lạnh Inverter',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.l10n.workerWarrantyCustomerInfo,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Divider(height: 1, color: AppColors.border),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              context.l10n.workerWarrantyNetIncome,
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            '0đ',
                            style: AppTextStyles.headlineSmall.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Customer Issue Section
                Text(
                  context.l10n.workerWarrantyCustomerIssueTitle,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.workerWarrantyCustomerIssue,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(child: _buildPhotoBox('IMG_0521')),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(child: _buildPhotoBox('IMG_0522')),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Original Order Details
                Text(
                  context.l10n.workerWarrantyOriginalOrderTitle,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.workerWarrantyOriginalCode,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.l10n.workerWarrantyOriginalDate,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.l10n.workerWarrantyOriginalRating,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: const Color(0xFFA35A06),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: _buildPhotoBox(
                              context.l10n.workerWarrantyBeforePhoto,
                              isLabel: true,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _buildPhotoBox(
                              context.l10n.workerWarrantyAfterPhoto,
                              isLabel: true,
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
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      unawaited(context.push(AppRoutes.workerWarrantyDecline));
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.control),
                      ),
                    ),
                    child: Text(
                      context.l10n.workerWarrantyDeclineCta,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: context.l10n.workerWarrantyAcceptCta,
                    icon: Icons.check_circle_outline_rounded,
                    onPressed: () {
                      unawaited(context.push(AppRoutes.workerEnRoute));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoBox(String title, {bool isLabel = false}) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFFF1EBE0),
        borderRadius: BorderRadius.circular(AppRadius.control),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.image_outlined, size: 28, color: AppColors.textMuted),
          ),
          Positioned(
            left: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xBA14312E),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
