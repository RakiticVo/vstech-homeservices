import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Privacy notice banner shown at the top of the chat thread.
///
/// Informs customer and worker that their phone numbers are completely masked.
class ChatPrivacyBanner extends StatelessWidget {
  const ChatPrivacyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.secondarySurface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            size: 15,
            color: AppColors.workerTeal,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              context.l10n.chatPrivacyBanner,
              style: AppTextStyles.labelMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.workerTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
