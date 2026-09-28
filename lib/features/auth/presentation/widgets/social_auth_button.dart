import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

enum SocialProvider { google, apple, facebook }

/// Social authentication button for third-party OAuth sign-in.
/// Styled strictly per Eco-Clean Sanctuary: Flat surface, 1px hairline border, Zero Shadows.
class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    required this.provider,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final SocialProvider provider;
  final String label;
  final VoidCallback onPressed;

  Widget _buildProviderIcon() {
    switch (provider) {
      case SocialProvider.google:
        return const Icon(
          Icons.g_mobiledata,
          size: 26,
          color: Color(0xFFEA4335),
        );
      case SocialProvider.apple:
        return const Icon(
          Icons.apple,
          size: 22,
          color: AppColors.textPrimary,
        );
      case SocialProvider.facebook:
        return const Icon(
          Icons.facebook,
          size: 22,
          color: Color(0xFF1877F2),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProviderIcon(),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.labelMd.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
