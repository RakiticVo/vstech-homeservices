import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/features/messaging/domain/models/chat_message.dart';

/// Renders a single message item inside the chat thread.
class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.message,
    required this.isMine,
    required this.isWorker,
    required this.isReadonly,
    super.key,
    this.onCallBack,
    this.onApproveExtraCost,
    this.onDeclineExtraCost,
  });

  final ChatMessage message;
  final bool isMine;
  final bool isWorker;
  final bool isReadonly;
  final VoidCallback? onCallBack;
  final VoidCallback? onApproveExtraCost;
  final VoidCallback? onDeclineExtraCost;

  static final RegExp _phoneRegex = RegExp(r'0\d{3}[\s.]?\d{3}[\s.]?\d{3}');

  String _maskPhone(String text) {
    return text.replaceAllMapped(_phoneRegex, (match) {
      final raw = match.group(0)!;
      final prefix = raw.length >= 4 ? raw.substring(0, 4) : raw;
      return '$prefix ••• •••';
    });
  }

  bool _hasPhone(String text) {
    return _phoneRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    final text = isEn ? message.textEn : message.textVi;

    switch (message.type) {
      case ChatMessageType.systemEvent:
      case ChatMessageType.callLog:
        return _buildSystemPill(context, text);

      case ChatMessageType.missedCall:
        return _buildMissedCallPill(context, text);

      case ChatMessageType.text:
      case ChatMessageType.photo:
      case ChatMessageType.location:
      case ChatMessageType.extraCost:
        return _buildBubble(context, text);
    }
  }

  Widget _buildSystemPill(BuildContext context, String text) {
    return Align(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.border.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(AppRadius.control),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.caption.copyWith(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildMissedCallPill(BuildContext context, String text) {
    final callerText = isWorker
        ? context.l10n.callMissedCustomer
        : context.l10n.callMissedWorker;
    final fullText = '$callerText · ${message.time}';

    return Align(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(color: const Color(0xFFFECACA)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.phone_missed_rounded, size: 14, color: AppColors.error),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                fullText,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.error,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!isReadonly && onCallBack != null) ...[
              const SizedBox(width: 8),
              InkWell(
                onTap: onCallBack,
                child: Text(
                  context.l10n.chatCallBack,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(BuildContext context, String text) {
    final hasPhone = _hasPhone(text);
    final displayedText = _maskPhone(text);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: const BoxConstraints(maxWidth: 290),
        child: Column(
          crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.type == ChatMessageType.extraCost)
              _buildExtraCostCard(context)
            else if (message.type == ChatMessageType.location)
              _buildLocationCard(context, displayedText)
            else if (message.type == ChatMessageType.photo)
              _buildPhotoCard(context, displayedText)
            else
              _buildTextBubble(context, displayedText),
            if (hasPhone)
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 4, right: 4),
                child: Text(
                  context.l10n.chatMaskedPhoneNote,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 4, right: 4),
              child: Text(
                _formatMeta(context),
                style: AppTextStyles.caption.copyWith(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextBubble(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
        text,
        style: AppTextStyles.bodyMedium.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isMine ? AppColors.onPrimary : AppColors.textPrimary,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildPhotoCard(BuildContext context, String caption) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.camera_alt_outlined,
                  size: 32,
                  color: AppColors.textMuted,
                ),
                const SizedBox(height: 6),
                Text(
                  caption,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline, size: 14, color: AppColors.primary),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'Hiện trường #01',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context, String subtitle) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 104,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF1EFEA),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _MiniMapPainter(),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      'GPS Live',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.chatCurrentLocation,
                  style: AppTextStyles.titleLg.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraCostCard(BuildContext context) {
    final status = message.extraCostStatus;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: status == ExtraCostStatus.pending
              ? AppColors.warning
              : (status == ExtraCostStatus.approved ? AppColors.primary : AppColors.error),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.report_problem_outlined,
                size: 14,
                color: status == ExtraCostStatus.pending ? AppColors.warning : AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  context.l10n.chatExtraCostBadge,
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                    color: AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.chatExtraCostTitle,
            style: AppTextStyles.titleLg.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            context.l10n.chatExtraCostDesc,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.chatExtraCostAmount,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          if (status == ExtraCostStatus.pending && !isWorker && !isReadonly) ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDeclineExtraCost,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.control),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      context.l10n.chatDecline,
                      style: AppTextStyles.labelMedium.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: onApproveExtraCost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.warning,
                      foregroundColor: const Color(0xFF3A2410),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.control),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      context.l10n.chatApprove,
                      style: AppTextStyles.labelMedium.copyWith(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF3A2410),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: status == ExtraCostStatus.approved
                    ? AppColors.secondarySurface
                    : (status == ExtraCostStatus.declined
                        ? const Color(0xFFFEE2E2)
                        : const Color(0xFFFEF3C7)),
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Row(
                children: [
                  Icon(
                    status == ExtraCostStatus.approved
                        ? Icons.check_circle_rounded
                        : (status == ExtraCostStatus.declined
                            ? Icons.cancel_rounded
                            : Icons.schedule_rounded),
                    size: 14,
                    color: status == ExtraCostStatus.approved
                        ? AppColors.primary
                        : (status == ExtraCostStatus.declined ? AppColors.error : AppColors.warning),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      status == ExtraCostStatus.approved
                          ? context.l10n.chatExtraCostApproved
                          : (status == ExtraCostStatus.declined
                              ? context.l10n.chatExtraCostDeclined
                              : context.l10n.chatExtraCostPendingWorker),
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: status == ExtraCostStatus.approved
                            ? AppColors.primary
                            : (status == ExtraCostStatus.declined ? AppColors.error : AppColors.warning),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatMeta(BuildContext context) {
    if (isMine) {
      final receipt = message.seen ? context.l10n.chatSeen : context.l10n.chatSent;
      return '${message.time} · $receipt';
    }
    return message.time;
  }
}

class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas
      ..drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), roadPaint)
      ..drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), roadPaint)
      ..drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), roadPaint)
      ..drawLine(Offset(size.width * 0.75, 0), Offset(size.width * 0.75, size.height), roadPaint);

    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width * 0.3, size.height * 0.3)
      ..lineTo(size.width * 0.3, size.height * 0.7)
      ..lineTo(size.width * 0.75, size.height * 0.7);

    canvas.drawPath(path, routePaint);

    final startPaint = Paint()..color = AppColors.primary;
    final endPaint = Paint()..color = AppColors.warning;
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas
      ..drawCircle(Offset(size.width * 0.3, size.height * 0.3), 5, startPaint)
      ..drawCircle(Offset(size.width * 0.3, size.height * 0.3), 5, borderPaint)
      ..drawCircle(Offset(size.width * 0.75, size.height * 0.7), 5, endPaint)
      ..drawCircle(Offset(size.width * 0.75, size.height * 0.7), 5, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
