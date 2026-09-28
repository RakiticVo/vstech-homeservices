import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/tracking_map_widget.dart';

/// Worker En Route Screen (`wgo` — Concept 02: Cell 44).
/// Displays live navigation route, destination, customer contact, and arrival confirmation.
class WorkerEnRoutePage extends StatelessWidget {
  const WorkerEnRoutePage({super.key});

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
          context.l10n.workerEnRouteTitle,
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
          // Map view with route & ETA
          const TrackingMapWidget(
            height: 250,
            workerEtaText: '8 phút · 2.4 km',
            destinationLabel: 'Căn hộ 802',
          ),
          const SizedBox(height: AppSpacing.md),

          // Open Google Maps Action
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.workerOpenNavigation)),
              );
            },
            icon: const Icon(Icons.navigation_outlined, color: AppColors.primary, size: 18),
            label: Text(
              context.l10n.workerOpenNavigation,
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.control),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Destination Address & Customer Note Card
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
                    const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      context.l10n.workerDestinationLabel,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Căn hộ 802, Tháp B, Chung cư Flora Novia',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '1453 Phạm Văn Đồng, P. Linh Tây, TP. Thủ Đức, TP.HCM',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 18),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          context.l10n.workerCustomerNote,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Customer Contact Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
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
                  child: const Icon(Icons.person_rounded, color: AppColors.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chị Mai (Khách hàng)',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
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
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.l10n.trackingMaskedCall)),
                    );
                  },
                  icon: const Icon(Icons.call_rounded, color: AppColors.primary),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.l10n.trackingChat)),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Primary CTA: "Tôi đã đến nơi"
          AppButton(
            label: context.l10n.workerArrivedConfirm,
            onPressed: () {
              unawaited(context.push(AppRoutes.workerArrived));
            },
          ),

          const SizedBox(height: AppSpacing.sm),

          // Secondary Action: "Huỷ việc"
          TextButton(
            onPressed: () {
              unawaited(
                showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                  backgroundColor: AppColors.surface,
                  title: Text(
                    context.l10n.workerCancelJobPrompt,
                    style: AppTextStyles.headlineSmall,
                  ),
                  content: Text(
                    'Huỷ việc khi đang di chuyển sẽ làm giảm tỷ lệ nhận việc (96% -> 95%). Bạn có chắc chắn muốn huỷ không?',
                    style: AppTextStyles.bodyMedium,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(
                        'Không',
                        style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).maybePop();
                      },
                      child: Text(
                        'Xác nhận huỷ',
                        style: AppTextStyles.labelLarge.copyWith(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ),
            );
            },
            child: Text(
              context.l10n.workerCancelJobPrompt,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
