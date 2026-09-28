import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Role badge displayed at the top of Auth screens (Login / Register).
/// Informs the user of the active role context and provides a quick "Switch role" trigger.
class AuthRoleBadge extends StatelessWidget {
  const AuthRoleBadge({
    required this.isWorker,
    required this.onSwitchRole,
    super.key,
  });

  final bool isWorker;
  final VoidCallback onSwitchRole;

  @override
  Widget build(BuildContext context) {
    final roleTitle = isWorker ? context.l10n.authRoleWorker : context.l10n.authRoleCustomer;
    final roleIcon = isWorker ? Icons.build_circle_outlined : Icons.person_outline;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondarySurface,
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            roleIcon,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            roleTitle,
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            height: 12,
            width: 1,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(width: AppSpacing.xs),
          InkWell(
            onTap: onSwitchRole,
            borderRadius: BorderRadius.circular(AppRadius.chip),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.authSwitchRole,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.swap_horiz,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
