import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Password Updated Screen (`passok` — Concept 02: Cell 29).
/// Restates the role in the confirmation, then returns to that role's login.
class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({
    super.key,
    this.role = 'customer',
  });

  final String role;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final roleLabel =
        role == 'worker' ? l10n.authRoleWorker : l10n.authRoleCustomer;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: AppColors.secondarySurface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: const Icon(
                          Icons.lock_reset_rounded,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.resetPasswordSuccessTitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineMd.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.resetPasswordSuccessBody(roleLabel),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppButton.primary(
                label: l10n.resetPasswordBackToLogin,
                onPressed: () => context.go('${AppRoutes.login}?role=$role'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
