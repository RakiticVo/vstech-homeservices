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

/// Screen 03 — Intro Value Proposition Screen (Slide 5 of Onboarding sequence).
/// Restates the 3 core values (100% Transparent, Auto Warranty, Rapid Dispatch)
/// alongside the iconic Vietnamese family illustration and a single commitment button.
class IntroValuePage extends StatelessWidget {
  const IntroValuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Brand + Language switch
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.control),
                        ),
                        child: const Icon(
                          Icons.home_repair_service_rounded,
                          size: 16,
                          color: AppColors.onPrimary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        context.l10n.appName,
                        style: AppTextStyles.titleLg.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const LanguageToggleButton(),
                ],
              ),
            ),

            // Scrollable Content Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),

                    // Main Headline
                    Text(
                      context.l10n.introTitle,
                      style: AppTextStyles.headlineLg.copyWith(
                        fontSize: 26,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Subtitle
                    Text(
                      context.l10n.introSubtitle,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // 3 Value Rows
                    _ValueItem(
                      icon: Icons.verified_user_outlined,
                      iconBg: AppColors.secondary,
                      iconColor: AppColors.primary,
                      title: context.l10n.value1Title,
                      description: context.l10n.value1Desc,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ValueItem(
                      icon: Icons.shield_outlined,
                      iconBg: const Color(0xFFE3F1EA),
                      iconColor: const Color(0xFF047857),
                      title: context.l10n.value2Title,
                      description: context.l10n.value2Desc,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ValueItem(
                      icon: Icons.electric_bolt_outlined,
                      iconBg: const Color(0xFFFDF0D8),
                      iconColor: const Color(0xFFA35A06),
                      title: context.l10n.value3Title,
                      description: context.l10n.value3Desc,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Family illustration
                    Container(
                      height: 180,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        AppAssets.ob5Family,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Single Primary Commitment CTA
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: AppButton(
                label: context.l10n.introCta,
                icon: Icons.arrow_forward,
                isFullWidth: true,
                onPressed: () => context.go(AppRoutes.roleGateway),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ValueItem extends StatelessWidget {
  const _ValueItem({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.titleLg.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
