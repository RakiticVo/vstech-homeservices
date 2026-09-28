import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing customer settings and logout dialog (Cells 113 & 116 `settings`).
class CustomerSettingsPage extends StatefulWidget {
  const CustomerSettingsPage({super.key});

  @override
  State<CustomerSettingsPage> createState() => _CustomerSettingsPageState();
}

class _CustomerSettingsPageState extends State<CustomerSettingsPage> {
  int _selectedTabIndex = 0;
  String _currentLang = 'Tiếng Việt';

  void _showAboutDialog() {
    final l10n = context.l10n;
    unawaited(
      showDialog<void>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            title: Text(
              l10n.settingsAboutDialogTitle,
              style: AppTextStyles.titleLg.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            content: Text(
              l10n.settingsAboutDialogBody,
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'Đóng',
                  style: AppTextStyles.bodyMd.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showLogoutSheet() {
    final l10n = context.l10n;
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (sheetCtx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.logoutDialogTitle,
                  style: AppTextStyles.headlineMd.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.logoutDialogBody,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    key: const Key('confirm_logout_button'),
                    onPressed: () {
                      Navigator.of(sheetCtx).pop();
                      context.go(AppRoutes.login);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                    ),
                    child: Text(
                      l10n.logoutConfirmCta,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    key: const Key('cancel_logout_button'),
                    onPressed: () => Navigator.of(sheetCtx).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                    ),
                    child: Text(
                      l10n.logoutCancelCta,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
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
              context.go(AppRoutes.customerProfile);
            }
          },
        ),
        title: Text(
          l10n.settingsTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            children: [
              // Tabs
              _buildTabBar(context),
              const SizedBox(height: AppSpacing.md),

              if (_selectedTabIndex == 0)
                _buildSettingsTab(context)
              else
                _buildHistoryTab(context),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          _buildTabItem(title: l10n.settingsTabSettings, index: 0),
          _buildTabItem(title: l10n.settingsTabHistory, index: 1),
        ],
      ),
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTab(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              // Language
              _buildSettingItem(
                icon: Icons.language,
                title: l10n.settingsLanguage,
                meta: _currentLang,
                onTap: () {
                  setState(() {
                    _currentLang =
                        _currentLang == 'Tiếng Việt' ? 'English' : 'Tiếng Việt';
                  });
                },
              ),
              const Divider(height: 1, color: AppColors.border),

              // Change Password
              _buildSettingItem(
                icon: Icons.lock_outline,
                title: l10n.settingsChangePassword,
                onTap: () => context.push(AppRoutes.changePassword),
              ),
              const Divider(height: 1, color: AppColors.border),

              // Payment Methods
              _buildSettingItem(
                icon: Icons.credit_card,
                title: l10n.settingsPaymentMethods,
                subtitle: l10n.settingsPaymentMethodsSub,
                onTap: () => context.push(AppRoutes.paymentMethods),
              ),
              const Divider(height: 1, color: AppColors.border),

              // Notification Settings
              _buildSettingItem(
                icon: Icons.notifications_none,
                title: l10n.profileMenuNotifications,
                onTap: () =>
                    context.push(AppRoutes.customerNotificationSettings),
              ),
              const Divider(height: 1, color: AppColors.border),

              // Help Center / Complaints
              _buildSettingItem(
                icon: Icons.help_outline,
                title: l10n.settingsHelpCenter,
                subtitle: l10n.settingsHelpCenterSub,
                onTap: () => context.push(AppRoutes.customerDisputeList),
              ),
              const Divider(height: 1, color: AppColors.border),

              // About
              _buildSettingItem(
                icon: Icons.info_outline,
                title: l10n.settingsAbout,
                subtitle: l10n.settingsAboutSub,
                onTap: _showAboutDialog,
              ),
              const Divider(height: 1, color: AppColors.border),

              // Delete Account
              _buildSettingItem(
                icon: Icons.delete_outline,
                title: l10n.settingsDeleteAccount,
                titleColor: AppColors.error,
                onTap: () => context.push(AppRoutes.deleteAccount),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Log out button tile
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: InkWell(
            key: const Key('open_logout_button'),
            borderRadius: BorderRadius.circular(AppRadius.card),
            onTap: _showLogoutSheet,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  const Icon(Icons.logout, color: AppColors.error, size: 20),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.settingsLogout,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        key: const Key('view_orders_history_button'),
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: () => context.push(AppRoutes.customerOrders),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xem toàn bộ đơn hàng',
                      style: AppTextStyles.titleLg.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Theo dõi tiến độ, hoá đơn và phiếu bảo hành',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
    String? meta,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md - 1,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: titleColor ?? AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: titleColor ?? AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (meta != null) ...[
              Text(
                meta,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            const Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
