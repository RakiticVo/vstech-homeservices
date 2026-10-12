import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/presentation/pages/voip_call_page.dart';

/// A call-log entry in the chat timeline: "Voice call · 00:48" or "Missed call", with its time.
class ChatCallLogPill extends StatelessWidget {
  const ChatCallLogPill({required this.call, super.key});

  final VoipCall call;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final missed = call.isMissed;
    final startedAt = call.startedAt?.toLocal();
    final label = [
      if (missed)
        l10n.callMissed
      else
        l10n.callVoiceLog(
          VoipCallPage.formatDuration(call.durationSeconds ?? 0),
        ),
      if (startedAt != null) DateFormat('HH:mm').format(startedAt),
    ].join(' · ');
    final color = missed ? AppColors.error : AppColors.textSecondary;

    return Align(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              missed ? Icons.phone_missed_outlined : Icons.call_outlined,
              size: 16,
              color: color,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
