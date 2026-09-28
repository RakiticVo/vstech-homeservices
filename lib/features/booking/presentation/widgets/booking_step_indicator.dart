import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Top progress indicator for the 3-step booking flow.
/// Adheres strictly to Master Spec v9.0:
/// - Pure white surface with 1px hairline border bottom
/// - Zero Shadows
/// - Active step in Primary Teal, completed steps in Mint with check, upcoming in border slate.
class BookingStepIndicator extends StatelessWidget implements PreferredSizeWidget {
  const BookingStepIndicator({
    required this.currentStep,
    required this.stepTitle,
    this.onBackPressed,
    super.key,
  });

  final int currentStep;
  final String stepTitle;
  final VoidCallback? onBackPressed;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surface,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top App Bar row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: onBackPressed ??
                        () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(AppRoutes.customerHome);
                          }
                        },
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          context.l10n.bookingTitle,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          context.l10n.bookingStepProgress(currentStep, stepTitle),
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48), // Balance leading back button
                ],
              ),
            ),

            // Step Progress Bars (3 steps)
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
              child: Row(
                children: List.generate(3, (index) {
                  final stepIndex = index + 1;
                  final isDone = stepIndex < currentStep;
                  final isActive = stepIndex == currentStep;

                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(
                        left: index > 0 ? 4 : 0,
                        right: index < 2 ? 4 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.primary
                            : (isActive ? AppColors.primary : AppColors.border),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(color: AppColors.border, height: 1),
          ],
        ),
      ),
    );
  }
}
