import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/language_toggle_button.dart';

/// Worker partner profile & settings screen (Cell 106 `wprofile`).
class WorkerProfilePage extends StatelessWidget {
  const WorkerProfilePage({super.key});

  Future<void> _showLogoutDialog(BuildContext context) async {
    final l10n = context.l10n;

    await showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Text(
          l10n.wprofileLogoutDialogTitle,
          style: AppTextStyles.headlineSm.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          l10n.wprofileLogoutDialogBody,
          style: AppTextStyles.bodyMd.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(
              l10n.logoutCancelCta,
              style: AppTextStyles.bodyMd.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            key: const Key('confirm_worker_logout_button'),
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              context.go(AppRoutes.roleGateway);
            },
            child: Text(
              l10n.logoutConfirmCta,
              style: AppTextStyles.bodyMd.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              context.go(AppRoutes.workerDashboard);
            }
          },
        ),
        title: Text(
          l10n.wprofileTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.md),
            child: Center(child: LanguageToggleButton()),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Worker Profile Header Card
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
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'TH',
                        style: AppTextStyles.headlineSm.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Trần Văn Hùng',
                                style: AppTextStyles.headlineSm.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.verified,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '0909 123 456',
                            style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.secondarySurface,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.chip),
                                  border: Border.all(color: AppColors.primary),
                                ),
                                child: Text(
                                  l10n.wprofileWorkerId('TH-8821'),
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFF59E0B),
                                size: 16,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '4.9 ★',
                                style: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
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
              const SizedBox(height: AppSpacing.xl),

              // Menu navigation options
              Text(
                'Quản lý hoạt động',
                style: AppTextStyles.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      key: const Key('menu_worker_skills'),
                      icon: Icons.psychology_outlined,
                      title: l10n.wprofileMenuSkills,
                      subtitle: '1 chứng chỉ hết hạn',
                      subtitleColor: AppColors.error,
                      onTap: () => context.push(AppRoutes.workerSkills),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _buildMenuItem(
                      key: const Key('menu_worker_zone'),
                      icon: Icons.map_outlined,
                      title: l10n.wprofileMenuZone,
                      subtitle: '4 quận · Bán kính 5 km',
                      onTap: () => context.push(AppRoutes.workerWorkZone),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _buildMenuItem(
                      key: const Key('menu_worker_schedule'),
                      icon: Icons.calendar_month_outlined,
                      title: l10n.wprofileMenuSchedule,
                      subtitle: '6 ngày/tuần · 08:00 – 18:00',
                      onTap: () => context.push(AppRoutes.workerSchedule),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _buildMenuItem(
                      key: const Key('menu_worker_perf'),
                      icon: Icons.speed_outlined,
                      title: l10n.wprofileMenuPerf,
                      subtitle: '4.9★ · Nhận việc 96%',
                      onTap: () => context.push(AppRoutes.workerPerformance),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _buildMenuItem(
                      key: const Key('menu_worker_payout'),
                      icon: Icons.account_balance_outlined,
                      title: l10n.wprofileMenuPayout,
                      subtitle: 'Vietcombank ••• 4821',
                      onTap: () => context.push(AppRoutes.workerWithdraw),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Logout CTA Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: InkWell(
                  key: const Key('worker_logout_button'),
                  onTap: () => _showLogoutDialog(context),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: AppColors.error,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          l10n.wprofileLogoutCta,
                          style: AppTextStyles.bodyMd.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required Key key,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? subtitleColor,
  }) {
    return InkWell(
      key: key,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySm.copyWith(
                      color: subtitleColor ?? AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
