import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Fixed Floating Bottom Navigation Dock for Customer role.
/// Adheres strictly to Master Spec v9.0: Capsule shape (rounded-full), white surface,
/// 1px hairline border, Zero Shadows, active tab in Teal pill.
///
/// Tabs navigate on their own ([navigate]) unless [onTabSelected] is given: Home and Orders replace
/// the current tab screen (`go`), AI / Notifications / Account open on top (`push`) so they keep
/// their back button.
class CustomerFloatingDock extends StatelessWidget {
  const CustomerFloatingDock({
    required this.currentIndex,
    this.onTabSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

  /// Opens tab [index] from the screen showing tab [currentIndex].
  static void navigate(
    BuildContext context, {
    required int index,
    required int currentIndex,
  }) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        context.go(AppRoutes.customerHome);
      case 1:
        context.go(AppRoutes.customerOrders);
      case 2:
        unawaited(context.push(AppRoutes.aiAssistant));
      case 3:
        unawaited(context.push(AppRoutes.customerNotifications));
      case 4:
        unawaited(context.push(AppRoutes.customerProfile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _DockTabItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: context.l10n.navHome,
      ),
      _DockTabItem(
        icon: Icons.receipt_long_outlined,
        activeIcon: Icons.receipt_long,
        label: context.l10n.navOrders,
      ),
      _DockTabItem(
        icon: Icons.auto_awesome_outlined,
        activeIcon: Icons.auto_awesome,
        label: context.l10n.navAi,
      ),
      _DockTabItem(
        icon: Icons.notifications_none_outlined,
        activeIcon: Icons.notifications,
        label: context.l10n.navNotifications,
      ),
      _DockTabItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: context.l10n.navAccount,
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final isSelected = index == currentIndex;
          final tab = tabs[index];

          return GestureDetector(
            onTap: () => onTabSelected != null
                ? onTabSelected!(index)
                : navigate(context, index: index, currentIndex: currentIndex),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? AppSpacing.md : AppSpacing.xs,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? tab.activeIcon : tab.icon,
                    size: 20,
                    color: isSelected
                        ? AppColors.onPrimary
                        : AppColors.textSecondary,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      tab.label,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _DockTabItem {
  const _DockTabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}
