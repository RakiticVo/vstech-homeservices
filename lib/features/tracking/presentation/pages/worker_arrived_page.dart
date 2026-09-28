import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Worker Arrived Screen (`warr` — Concept 02: Cell 46).
/// Confirms worker on-site presence, provides no-show escalation, and starts the job.
class WorkerArrivedPage extends StatelessWidget {
  const WorkerArrivedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          context.l10n.workerArrivedTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Success Presence Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.success),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.success,
                    size: 38,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  context.l10n.trackingCheckInAt('13:58'),
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  context.l10n.workerArrivedDesc,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Customer and Location Summary
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
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.secondarySurface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.home_work_rounded, color: AppColors.primary),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chị Mai · Căn hộ 802, Tháp B',
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Dọn dẹp căn hộ 70m²',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(context.l10n.trackingMaskedCall)),
                          );
                        },
                        icon: const Icon(Icons.call_rounded, size: 18),
                        label: Text(context.l10n.trackingMaskedCall),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.control),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(context.l10n.trackingChat)),
                          );
                        },
                        icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                        label: Text(context.l10n.trackingChat),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.control),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Primary CTA: "Bắt đầu làm việc"
          AppButton(
            label: context.l10n.workerStartJobCta,
            onPressed: () {
              unawaited(context.push(AppRoutes.workerExecuting));
            },
          ),

          const SizedBox(height: AppSpacing.md),

          // Escalation Option: "Khách không có mặt?"
          Center(
            child: TextButton.icon(
              onPressed: () {
                unawaited(
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.surface,
                    title: Text(
                      context.l10n.workerCustomerNoShow,
                      style: AppTextStyles.headlineSmall,
                    ),
                    content: const Text(
                      'Nếu sau 15 phút thợ đã có mặt mà không thể liên hệ được với khách, hệ thống sẽ hỗ trợ kết thúc đơn và bồi hoàn +50.000đ phí di chuyển cho bạn.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text(
                          'Đã hiểu',
                          style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              },
              icon: const Icon(Icons.help_outline_rounded, size: 18, color: AppColors.textSecondary),
              label: Text(
                context.l10n.workerCustomerNoShow,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
