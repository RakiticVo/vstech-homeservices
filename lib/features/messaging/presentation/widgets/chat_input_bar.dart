import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Bottom bar for sending messages, photos, locations, or showing closed notice.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    required this.controller,
    required this.isClosed,
    required this.onSend,
    required this.onAddPhoto,
    required this.onAddLocation,
    super.key,
  });

  final TextEditingController controller;
  final bool isClosed;
  final VoidCallback onSend;
  final VoidCallback onAddPhoto;
  final VoidCallback onAddLocation;

  @override
  Widget build(BuildContext context) {
    if (isClosed) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Text(
          context.l10n.chatClosedNotice,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined, size: 22, color: AppColors.textSecondary),
              onPressed: onAddPhoto,
              tooltip: 'Gửi ảnh',
            ),
            IconButton(
              icon: const Icon(Icons.location_on_outlined, size: 22, color: AppColors.textSecondary),
              onPressed: onAddLocation,
              tooltip: 'Gửi vị trí',
            ),
            Expanded(
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: context.l10n.chatInputHint,
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: onSend,
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  size: 19,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
