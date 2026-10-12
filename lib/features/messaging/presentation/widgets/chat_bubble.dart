import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';

/// One text message. Phone numbers are masked on screen (privacy rule of the chat brief); my own
/// messages also show Sent / Seen from `isRead`.
class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, required this.isMine, super.key});

  final ChatRoomMessage message;
  final bool isMine;

  static final RegExp _phone = RegExp(
    r'(?:\+84|0)\d{2,3}[\s.]?\d{3}[\s.]?\d{3,4}',
  );

  static bool hasPhone(String text) => _phone.hasMatch(text);

  /// "0901 234 567" → "0901 ••• •••".
  static String maskPhones(String text) =>
      text.replaceAllMapped(_phone, (match) {
        final raw = match.group(0)!;
        return '${raw.substring(0, raw.length < 4 ? raw.length : 4)} ••• •••';
      });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sentAt = message.sentAt?.toLocal();
    final meta = [
      if (sentAt != null) DateFormat('HH:mm').format(sentAt),
      if (isMine && message.isRead)
        l10n.chatSeen
      else if (isMine)
        l10n.chatSent,
    ].join(' · ');

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 290),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(
            crossAxisAlignment: isMine
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isMine ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isMine ? 18 : 6),
                    bottomRight: Radius.circular(isMine ? 6 : 18),
                  ),
                  border: Border.all(
                    color: isMine ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Text(
                  maskPhones(message.text),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isMine ? AppColors.onPrimary : AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
              if (hasPhone(message.text))
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 4, right: 4),
                  child: Text(
                    l10n.chatMaskedPhoneNote,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              if (meta.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 4, right: 4),
                  child: Text(
                    meta,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
