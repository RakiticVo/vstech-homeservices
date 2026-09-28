import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Card previewing the "Your Home & Devices" health log and maintenance schedule.
class HomeDevicesCard extends StatelessWidget {
  const HomeDevicesCard({
    super.key,
    this.onViewSchedule,
  });

  final VoidCallback? onViewSchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Title & Action Link
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.homeSectionDevices,
                style: AppTextStyles.titleLg.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: onViewSchedule,
                child: Text(
                  context.l10n.homeViewSchedule,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            context.l10n.homeDeviceSubtitle,
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: AppSpacing.md),

          // Device Item 1: Daikin AC
          _DeviceRow(
            iconAsset: AppAssets.devAc,
            deviceName: context.l10n.deviceDaikinAc,
            lastServiceDate: context.l10n.deviceLastService('15/03/2026'),
            statusLabel: context.l10n.deviceStatusGood,
            isHealthy: true,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Divider(color: AppColors.border),
          ),

          // Device Item 2: Samsung Fridge
          _DeviceRow(
            iconAsset: AppAssets.devFridge,
            deviceName: context.l10n.deviceSamsungFridge,
            lastServiceDate: context.l10n.deviceLastService('10/11/2025'),
            statusLabel: context.l10n.deviceStatusMaintenance,
            isHealthy: false,
          ),
        ],
      ),
    );
  }
}

class _DeviceRow extends StatelessWidget {
  const _DeviceRow({
    required this.iconAsset,
    required this.deviceName,
    required this.lastServiceDate,
    required this.statusLabel,
    required this.isHealthy,
  });

  final String iconAsset;
  final String deviceName;
  final String lastServiceDate;
  final String statusLabel;
  final bool isHealthy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Device icon container
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(color: AppColors.border),
          ),
          child: Image.asset(
            iconAsset,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(
              Icons.devices_outlined,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),

        // Device name and last service
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deviceName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelMd.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                lastServiceDate,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: AppSpacing.xs),

        // Status Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: isHealthy
                ? AppColors.success.withValues(alpha: 0.12)
                : AppColors.warning.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.chip),
            border: Border.all(
              color: isHealthy
                  ? AppColors.success.withValues(alpha: 0.3)
                  : AppColors.warning.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isHealthy ? AppColors.success : AppColors.warning,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                statusLabel,
                style: AppTextStyles.caption.copyWith(
                  color: isHealthy ? AppColors.successDark : AppColors.warning,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
