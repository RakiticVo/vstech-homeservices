import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_assets.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/language_toggle_button.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/role_selection_card.dart';

enum AppUserRole { customer, worker }

/// Screen 04 — Role Gateway Screen.
/// 50/50 dual-role portal ("Cần sửa chữa & Dịch vụ" vs "Đi làm & Tăng thu nhập").
/// Allows instantaneous role picking, live language toggling (VI/EN), and leads into Auth.
class RoleGatewayPage extends StatefulWidget {
  const RoleGatewayPage({super.key});

  @override
  State<RoleGatewayPage> createState() => _RoleGatewayPageState();
}

class _RoleGatewayPageState extends State<RoleGatewayPage> {
  AppUserRole _selectedRole = AppUserRole.customer;

  void _onContinue() {
    // Navigate to Login/Auth with the selected role context
    final roleQuery = _selectedRole == AppUserRole.customer ? 'customer' : 'worker';
    unawaited(context.push('${AppRoutes.login}?role=$roleQuery'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Brand Icon & Language Toggle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                      ),
                      child: const Icon(
                        Icons.home_repair_service_rounded,
                        size: 22,
                        color: AppColors.onPrimary,
                      ),
                    ),
                    const LanguageToggleButton(),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Title & Subtitle
              Text(
                context.l10n.roleGatewayTitle,
                style: AppTextStyles.headlineLg.copyWith(
                  fontSize: 26,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.l10n.roleGatewaySubtitle,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Role Selection Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Role 1: Customer
                      RoleSelectionCard(
                        iconAsset: AppAssets.navHome,
                        title: context.l10n.roleCustomerTitle,
                        description: context.l10n.roleCustomerDesc,
                        actionText: context.l10n.roleCustomerAction,
                        isSelected: _selectedRole == AppUserRole.customer,
                        onTap: () => setState(() => _selectedRole = AppUserRole.customer),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Role 2: Worker
                      RoleSelectionCard(
                        iconAsset: AppAssets.utTech,
                        title: context.l10n.roleWorkerTitle,
                        description: context.l10n.roleWorkerDesc,
                        actionText: context.l10n.roleWorkerAction,
                        isSelected: _selectedRole == AppUserRole.worker,
                        onTap: () => setState(() => _selectedRole = AppUserRole.worker),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Notice Text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 16,
                            color: AppColors.textMuted,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              context.l10n.switchRoleNotice,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textMuted,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Primary Action Button
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: AppButton(
                  label: context.l10n.continueText,
                  icon: Icons.arrow_forward,
                  isFullWidth: true,
                  onPressed: _onContinue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
