import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Horizontal quick replies bar above the input field.
class ChatQuickRepliesBar extends StatelessWidget {
  const ChatQuickRepliesBar({
    required this.isWorker,
    required this.onSelect,
    super.key,
  });

  final bool isWorker;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final replies = isWorker
        ? [
            context.l10n.chatQuickWorker1,
            context.l10n.chatQuickWorker2,
            context.l10n.chatQuickWorker3,
            context.l10n.chatQuickWorker4,
          ]
        : [
            context.l10n.chatQuickCustomer1,
            context.l10n.chatQuickCustomer2,
            context.l10n.chatQuickCustomer3,
            context.l10n.chatQuickCustomer4,
          ];

    return Container(
      height: 38,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: replies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final text = replies[index];
          return InkWell(
            onTap: () => onSelect(text),
            borderRadius: BorderRadius.circular(AppRadius.full),
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.full),
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              child: Text(
                text,
                style: AppTextStyles.labelMedium.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
