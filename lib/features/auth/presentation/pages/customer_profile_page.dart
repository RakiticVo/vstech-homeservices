import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing customer profile overview & menu options (Cell 104 `profile`).
class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});

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
              context.go(AppRoutes.customerHome);
            }
          },
        ),
        title: Text(
          l10n.profileTitle,
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
              // User header card
              _buildUserCard(context),
              const SizedBox(height: AppSpacing.md),

              // Menu Options Card
              _buildMenuCard(context),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'M',
              style: AppTextStyles.headlineMd.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nguyễn Thị Mai',
                  style: AppTextStyles.titleLg.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'maingvyen@gmail.com',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            key: const Key('profile_edit_link'),
            onPressed: () => context.push(AppRoutes.editProfile),
            child: Text(
              l10n.profileEditLink,
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    final l10n = context.l10n;

    final menuItems = [
      _ProfileMenuItem(
        icon: Icons.person_outline,
        title: l10n.profileMenuPersonalInfo,
        route: AppRoutes.editProfile,
      ),
      _ProfileMenuItem(
        icon: Icons.location_on_outlined,
        title: l10n.profileMenuAddresses,
        meta: '2',
        route: AppRoutes.myAddresses,
      ),
      _ProfileMenuItem(
        icon: Icons.favorite_border,
        title: l10n.profileMenuFavourites,
        meta: '2',
        route: AppRoutes.favouritePros,
      ),
      _ProfileMenuItem(
        icon: Icons.credit_card_outlined,
        title: l10n.profileMenuPayment,
        meta: '2 ví',
        route: AppRoutes.paymentMethods,
      ),
      _ProfileMenuItem(
        icon: Icons.notifications_none,
        title: l10n.profileMenuNotifications,
        route: AppRoutes.customerNotificationSettings,
      ),
      _ProfileMenuItem(
        icon: Icons.settings_outlined,
        title: l10n.profileMenuSettings,
        route: AppRoutes.customerSettings,
      ),
      _ProfileMenuItem(
        icon: Icons.help_outline,
        title: l10n.profileMenuComplaints,
        route: AppRoutes.customerDisputeList,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == menuItems.length - 1;

          return InkWell(
            key: Key('profile_menu_${item.route}'),
            onTap: () => context.push(item.route),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md - 1,
              ),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(color: AppColors.border),
                      ),
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      item.title,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (item.meta != null) ...[
                    Text(
                      item.meta!,
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
        }).toList(),
      ),
    );
  }
}

class _ProfileMenuItem {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.route,
    this.meta,
  });

  final IconData icon;
  final String title;
  final String route;
  final String? meta;
}
