import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/chat_cubit.dart';
import 'package:vstech_home_services/features/messaging/presentation/widgets/chat_bubble.dart';
import 'package:vstech_home_services/features/messaging/presentation/widgets/chat_input_bar.dart';
import 'package:vstech_home_services/features/messaging/presentation/widgets/chat_privacy_banner.dart';
import 'package:vstech_home_services/features/messaging/presentation/widgets/chat_quick_replies_bar.dart';

/// Booking chat for customer & worker (`chat` — Cells 80, 81, 84): history from
/// `GET /chat/rooms/{id}/messages` (oldest first, "load older" on top), live messages over
/// `/ws/chat/{roomId}` with a connection status row, text sending + quick replies. A closed room is
/// read-only. The API exposes no participant names, so the header shows the peer's role.
class ChatPage extends StatefulWidget {
  const ChatPage({required this.bookingId, required this.isWorker, super.key});

  final String bookingId;
  final bool isWorker;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _lastCount = 0;

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
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _send(String text) async {
    if (text.trim().isEmpty) return;
    final sent = await context.read<ChatCubit>().send(text);
    if (sent && mounted && _textController.text.trim() == text.trim()) {
      _textController.clear();
    }
  }

  void _openCall() => unawaited(
    context.push(
      AppRoutes.voipCallLocation(
        bookingId: widget.bookingId,
        isWorker: widget.isWorker,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final peer = widget.isWorker ? l10n.chatPeerCustomer : l10n.chatPeerWorker;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(
                widget.isWorker
                    ? AppRoutes.workerDashboard
                    : AppRoutes.customerHome,
              );
            }
          },
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              peer,
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              l10n.chatOrderLabel(widget.bookingId),
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (previous, current) =>
                _isClosed(previous) != _isClosed(current),
            builder: (context, state) => Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: AppSecondaryButton(
                key: const Key('chat_call_button'),
                label: l10n.trackingMaskedCall,
                icon: Icons.call_outlined,
                onPressed: _isClosed(state) ? null : _openCall,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is! ChatLoadedState) return;
          if (state.actionFailure case final failure?) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(l10n.failureMessage(failure))),
              );
          }
          final newest = state.messages.length;
          if (newest > _lastCount && !state.isLoadingOlder) _scrollToBottom();
          _lastCount = newest;
        },
        builder: (context, state) => switch (state) {
          ChatLoadingState() => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          ChatErrorState(:final failure, :final isRoomClosed) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Align(
              alignment: Alignment.topCenter,
              child: isRoomClosed
                  ? _ClosedRoomNotice(
                      title: l10n.chatRoomClosedTitle,
                      body: l10n.chatClosedNotice,
                    )
                  : ErrorRetryView(
                      message: l10n.failureMessage(failure),
                      onRetry: () =>
                          unawaited(context.read<ChatCubit>().retry()),
                    ),
            ),
          ),
          ChatLoadedState() => _ChatBody(
            state: state,
            isWorker: widget.isWorker,
            controller: _textController,
            scrollController: _scrollController,
            onSend: _send,
          ),
        },
      ),
    );
  }

  static bool _isClosed(ChatState state) =>
      (state is ChatLoadedState && state.room.isClosed) ||
      (state is ChatErrorState && state.isRoomClosed);
}

class _ChatBody extends StatelessWidget {
  const _ChatBody({
    required this.state,
    required this.isWorker,
    required this.controller,
    required this.scrollController,
    required this.onSend,
  });

  final ChatLoadedState state;
  final bool isWorker;
  final TextEditingController controller;
  final ScrollController scrollController;
  final Future<void> Function(String text) onSend;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<ChatCubit>();
    final closed = state.room.isClosed;
    final leading = state.hasMore ? 1 : 0;

    return Column(
      children: [
        const ChatPrivacyBanner(),
        if (!closed)
          _ConnectionRow(
            status: state.connection,
            onReconnect: () => unawaited(cubit.reconnect()),
          ),
        Expanded(
          child: state.messages.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Text(
                      l10n.chatEmpty,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  key: const Key('chat_message_list'),
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  itemCount: state.messages.length + leading,
                  itemBuilder: (context, index) {
                    if (index < leading) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppSecondaryButton(
                          key: const Key('chat_load_older'),
                          label: l10n.chatLoadOlder,
                          icon: state.isLoadingOlder
                              ? null
                              : Icons.expand_less_rounded,
                          isFullWidth: true,
                          onPressed: state.isLoadingOlder
                              ? null
                              : () => unawaited(cubit.loadOlder()),
                        ),
                      );
                    }
                    final message = state.messages[index - leading];
                    return ChatBubble(
                      key: Key('chat_message_${message.id}'),
                      message: message,
                      isMine: state.isMine(message),
                    );
                  },
                ),
        ),
        if (!closed)
          ChatQuickRepliesBar(
            isWorker: isWorker,
            onSelect: (text) => unawaited(onSend(text)),
          ),
        ChatInputBar(
          controller: controller,
          isClosed: closed,
          isSending: state.isSending,
          onSend: () => unawaited(onSend(controller.text)),
        ),
      ],
    );
  }
}

/// Live / connecting / offline — always Icon + Label + Color.
class _ConnectionRow extends StatelessWidget {
  const _ConnectionRow({required this.status, required this.onReconnect});

  final ChatConnectionStatus status;
  final VoidCallback onReconnect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (IconData icon, Color color, String label) = switch (status) {
      ChatConnectionStatus.connected => (
        Icons.wifi_rounded,
        AppColors.successDark,
        l10n.chatConnLive,
      ),
      ChatConnectionStatus.connecting || ChatConnectionStatus.reconnecting => (
        Icons.sync_rounded,
        AppColors.textSecondary,
        l10n.chatConnConnecting,
      ),
      ChatConnectionStatus.offline => (
        Icons.wifi_off_rounded,
        AppColors.error,
        l10n.chatConnOffline,
      ),
    };
    return Container(
      key: Key('chat_connection_${status.name}'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (status == ChatConnectionStatus.offline)
            AppSecondaryButton(
              key: const Key('chat_reconnect'),
              label: l10n.chatReconnect,
              icon: Icons.refresh_rounded,
              onPressed: onReconnect,
            ),
        ],
      ),
    );
  }
}

class _ClosedRoomNotice extends StatelessWidget {
  const _ClosedRoomNotice({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      children: [
        const Icon(
          Icons.lock_outline_rounded,
          color: AppColors.textMuted,
          size: 24,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          title,
          style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          body,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}
