import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Screen representing the interactive AI Assistant chat (Cell 102 `chat` / `ai-chat`).
class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({super.key});

  @override
  State<AiAssistantPage> createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_AiChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Seed initial welcome message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _messages.add(
            _AiChatMessage(
              text: context.l10n.aiAssistantWelcome,
              isUser: false,
              timestamp: '14:20',
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMsg = _AiChatMessage(
      text: text.trim(),
      isUser: true,
      timestamp: '14:21',
    );

    setState(() {
      _messages.add(userMsg);
      _textController.clear();
    });
    _scrollToBottom();

    // AI automated answer
    final l10n = context.l10n;
    var botReply = l10n.aiResponseWarranty;
    if (text.contains('dọn nhà') || text.contains('cleaning') || text.contains('Chi phí')) {
      botReply = l10n.aiResponseHouseCleaningCost;
    } else if (text.contains('máy lạnh') || text.contains('air-con') || text.contains('vệ sinh')) {
      botReply = l10n.aiResponseAcClean;
    } else if (text.contains('sửa điện') || text.contains('electrician')) {
      botReply = l10n.aiResponseBookElectrician;
    } else if (text.contains('Gợi ý') || text.contains('Suggest')) {
      unawaited(context.push(AppRoutes.aiSuggestions));
      return;
    }

    unawaited(
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          setState(() {
            _messages.add(
              _AiChatMessage(
                text: botReply,
                isUser: false,
                timestamp: '14:21',
              ),
            );
          });
          _scrollToBottom();
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final chips = [
      l10n.aiChipSuggestService,
      l10n.aiChipHouseCleaningCost,
      l10n.aiChipCleanAcAtHome,
      l10n.aiChipBookElectrician,
      l10n.aiChipWarrantyPolicy,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.customerHome);
            }
          },
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2FB),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Color(0xFF2563EB),
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.aiAssistantTitle,
                    style: AppTextStyles.titleLg.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.aiAssistantOnlineStatus,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat message stream
            Expanded(
              child: ListView(
                key: const Key('ai_message_list'),
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                children: [
                  ..._messages.map(_buildMessageBubble),

                  // Intent suggestion chips
                  const SizedBox(height: AppSpacing.sm),
                  Padding(
                    padding: const EdgeInsets.only(left: 42),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: chips.map((chipText) {
                        return InkWell(
                          key: Key('ai_chip_${chipText.hashCode}'),
                          onTap: () {
                            if (chipText == l10n.aiChipSuggestService) {
                              unawaited(context.push(AppRoutes.aiSuggestions));
                            } else {
                              _sendMessage(chipText);
                            }
                          },
                          borderRadius: BorderRadius.circular(AppRadius.control),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondarySurface,
                              borderRadius: BorderRadius.circular(AppRadius.control),
                              border: Border.all(color: const Color(0xFFCFE0D9)),
                            ),
                            child: Text(
                              chipText,
                              style: AppTextStyles.bodyMd.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),

            // Bottom Input Bar
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(color: AppColors.border),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        border: Border.all(color: AppColors.border),
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        key: const Key('ai_input_field'),
                        controller: _textController,
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.aiAssistantInputPlaceholder,
                          hintStyle: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.textMuted,
                          ),
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      key: const Key('ai_send_button'),
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => _sendMessage(_textController.text),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(_AiChatMessage msg) {
    if (msg.isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md, left: 60),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Text(
            msg.text,
            style: AppTextStyles.bodyMd.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FB),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Color(0xFF2563EB),
              size: 18,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 40),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                msg.text,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiChatMessage {
  const _AiChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  final String text;
  final bool isUser;
  final String timestamp;
}
