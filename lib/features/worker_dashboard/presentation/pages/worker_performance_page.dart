import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Worker performance metrics & badges screen (Cell 128 `wperf`).
class WorkerPerformancePage extends StatelessWidget {
  const WorkerPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.pop();
            }
          },
        ),
        title: Text(
          l10n.wperfTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating Overview Card
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFF59E0B),
                          size: 36,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '4.9',
                          style: AppTextStyles.displayMd.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.wperfRatingSubtitle,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Text(
                        'Kỹ thuật viên Xuất sắc · Hạng Vàng',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // 4 Metrics with Progress Bars
              Text(
                'Chỉ số hoạt động',
                style: AppTextStyles.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              _buildMetricCard(
                title: l10n.wperfAcceptRate,
                value: '96%',
                target: '≥ 90%',
                description: l10n.wperfAcceptDesc,
                progress: 0.96,
                isGood: true,
              ),
              const SizedBox(height: AppSpacing.md),

              _buildMetricCard(
                title: l10n.wperfCompRate,
                value: '98%',
                target: '≥ 95%',
                description: l10n.wperfCompDesc,
                progress: 0.98,
                isGood: true,
              ),
              const SizedBox(height: AppSpacing.md),

              _buildMetricCard(
                title: l10n.wperfOnTimeRate,
                value: '94%',
                target: '≥ 90%',
                description: l10n.wperfOnTimeDesc,
                progress: 0.94,
                isGood: true,
              ),
              const SizedBox(height: AppSpacing.md),

              _buildMetricCard(
                title: l10n.wperfWarrantyRate,
                value: '2%',
                target: '≤ 5%',
                description: l10n.wperfWarrantyDesc,
                progress: 0.20, // 2% out of 10% max scale
                isGood: true,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Section: Badges
              Text(
                l10n.wperfBadgesTitle,
                style: AppTextStyles.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.35,
                children: [
                  _buildBadgeCard(
                    iconText: '⏱',
                    title: l10n.wperfBadgePunctual,
                    description: l10n.wperfBadgePunctualDesc,
                    isUnlocked: true,
                  ),
                  _buildBadgeCard(
                    iconText: '100',
                    title: l10n.wperfBadge100,
                    description: l10n.wperfBadge100Desc,
                    isUnlocked: true,
                  ),
                  _buildBadgeCard(
                    iconText: '❤️',
                    title: l10n.wperfBadgeFav,
                    description: l10n.wperfBadgeFavDesc,
                    isUnlocked: true,
                  ),
                  _buildBadgeCard(
                    iconText: '🔒',
                    title: l10n.wperfBadgeNoComplaint,
                    description: l10n.wperfBadgeNoComplaintDesc,
                    isUnlocked: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String target,
    required String description,
    required double progress,
    required bool isGood,
  }) {
    return Container(
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
                title,
                style: AppTextStyles.bodyMd.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: AppTextStyles.headlineSm.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isGood ? AppColors.primary : AppColors.error,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '($target)',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: AppColors.secondary,
              valueColor: AlwaysStoppedAnimation<Color>(
                isGood ? AppColors.primary : AppColors.error,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeCard({
    required String iconText,
    required String title,
    required String description,
    required bool isUnlocked,
  }) {
    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.45,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isUnlocked ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isUnlocked ? AppColors.primary : AppColors.border,
            width: isUnlocked ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isUnlocked ? AppColors.surface : AppColors.background,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                iconText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: AppTextStyles.bodyMd.copyWith(
                fontWeight: FontWeight.w700,
                color: isUnlocked ? AppColors.primary : AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
