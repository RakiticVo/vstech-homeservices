import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/features/messaging/domain/models/chat_message.dart';
import 'package:vstech_home_services/features/messaging/presentation/widgets/chat_input_bar.dart';
import 'package:vstech_home_services/features/messaging/presentation/widgets/chat_message_bubble.dart';
import 'package:vstech_home_services/features/messaging/presentation/widgets/chat_privacy_banner.dart';
import 'package:vstech_home_services/features/messaging/presentation/widgets/chat_quick_replies_bar.dart';

/// In-app chat screen for Customer & Worker (`chat` — Cells 80, 81, 84).
class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.role = 'customer',
    this.isClosed = false,
    this.orderCode = '#HS20250425-0012',
    this.peerName,
    this.orderStatus = 'Đang thực hiện',
  });

  final String role;
  final bool isClosed;
  final String orderCode;
  final String? peerName;
  final String orderStatus;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  Timer? _typingTimer;

  late final List<ChatMessage> _messages;

  bool get _isWorker => widget.role == 'worker';

  @override
  void initState() {
    super.initState();
    _messages = [
      const ChatMessage(
        id: '1',
        sender: ChatSender.system,
        type: ChatMessageType.systemEvent,
        textVi: 'Anh Hùng đã nhận việc · 13:12',
        textEn: 'Hùng accepted the job · 13:12',
        time: '13:12',
      ),
      const ChatMessage(
        id: '2',
        sender: ChatSender.worker,
        type: ChatMessageType.text,
        textVi: 'Chào chị Mai, em là Hùng. Em sẽ có mặt lúc 14:00 ạ.',
        textEn: "Hi Mai, I'm Hùng. I'll be there at 14:00.",
        time: '13:14',
      ),
      const ChatMessage(
        id: '3',
        sender: ChatSender.customer,
        type: ChatMessageType.text,
        textVi: 'Ok em. Nhà chị tầng 12, gửi xe ở hầm B1 nhé.',
        textEn: "OK. I'm on floor 12; park in basement B1.",
        time: '13:15',
      ),
      const ChatMessage(
        id: '4',
        sender: ChatSender.worker,
        type: ChatMessageType.location,
        textVi: 'Cách 2,4 km · còn 8 phút',
        textEn: '2.4 km away · 8 min',
        time: '13:40',
      ),
      const ChatMessage(
        id: '5',
        sender: ChatSender.system,
        type: ChatMessageType.callLog,
        textVi: 'Cuộc gọi thoại · 0:48',
        textEn: 'Voice call · 0:48',
        time: '13:52',
      ),
      const ChatMessage(
        id: '6',
        sender: ChatSender.customer,
        type: ChatMessageType.text,
        textVi: 'Nếu cần thì gọi chị số 0901 234 567 nha.',
        textEn: 'If needed, call me on 0901 234 567.',
        time: '13:53',
        isMasked: true,
      ),
      const ChatMessage(
        id: '7',
        sender: ChatSender.system,
        type: ChatMessageType.systemEvent,
        textVi: 'Thợ đã đến · check-in 13:58',
        textEn: 'Arrived · checked in at 13:58',
        time: '13:58',
      ),
      const ChatMessage(
        id: '8',
        sender: ChatSender.worker,
        type: ChatMessageType.photo,
        textVi: 'Ron vòi sen bị mục',
        textEn: 'Worn shower-head seal',
        time: '14:40',
      ),
      const ChatMessage(
        id: '9',
        sender: ChatSender.worker,
        type: ChatMessageType.extraCost,
        textVi: 'Thay ron vòi sen',
        textEn: 'Replace shower-head seal',
        time: '14:41',
      ),
      const ChatMessage(
        id: '10',
        sender: ChatSender.system,
        type: ChatMessageType.missedCall,
        textVi: 'Cuộc gọi nhỡ · 15:05',
        textEn: 'Missed call · 15:05',
        time: '15:05',
      ),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _typingTimer?.cancel();
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

    final myRole = _isWorker ? ChatSender.worker : ChatSender.customer;
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          sender: myRole,
          type: ChatMessageType.text,
          textVi: text,
          textEn: text,
          time: '16:02',
        ),
      );
      _textController.clear();
    });
    _scrollToBottom();

    // Simulate reply after 1.4s
    _typingTimer?.cancel();
    setState(() => _isTyping = true);
    _typingTimer = Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        final peerRole = _isWorker ? ChatSender.customer : ChatSender.worker;
        final replyText = _isWorker
            ? 'Dạ em cảm ơn chị, em nhận được tin nhắn rồi ạ!'
            : 'Anh ơi, anh đã đến nơi chưa ạ?';
        _messages.add(
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            sender: peerRole,
            type: ChatMessageType.text,
            textVi: replyText,
            textEn: replyText,
            time: '16:03',
            seen: true,
          ),
        );
      });
      _scrollToBottom();
    });
  }

  void _addPhotoMessage() {
    final myRole = _isWorker ? ChatSender.worker : ChatSender.customer;
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          sender: myRole,
          type: ChatMessageType.photo,
          textVi: 'Ảnh chụp hiện trường',
          textEn: 'Scene photo',
          time: '16:03',
        ),
      );
    });
    _scrollToBottom();
  }

  void _addLocationMessage() {
    final myRole = _isWorker ? ChatSender.worker : ChatSender.customer;
    final locText = _isWorker ? 'Cách 0,3 km · còn 2 phút' : 'Căn hộ Flora Novia, Thủ Đức';
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          sender: myRole,
          type: ChatMessageType.location,
          textVi: locText,
          textEn: locText,
          time: '16:03',
        ),
      );
    });
    _scrollToBottom();
  }

  void _handleApproveExtraCost(int index) {
    setState(() {
      _messages[index] = _messages[index].copyWith(
        extraCostStatus: ExtraCostStatus.approved,
      );
    });
  }

  void _handleDeclineExtraCost(int index) {
    setState(() {
      _messages[index] = _messages[index].copyWith(
        extraCostStatus: ExtraCostStatus.declined,
      );
    });
  }

  void _navigateToCall() {
    final peer = widget.peerName ?? (_isWorker ? 'Nguyễn Thị Mai' : 'Trần Văn Hùng');
    unawaited(
      context.push(
        '${AppRoutes.voipCall}?role=${widget.role}&mode=callout&peer=$peer&order=${widget.orderCode}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPeer = _isWorker ? 'Nguyễn Thị Mai' : 'Trần Văn Hùng';
    final peer = widget.peerName ?? defaultPeer;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(_isWorker ? AppRoutes.workerDashboard : AppRoutes.customerHome);
            }
          },
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _isWorker ? AppColors.primary : const Color(0xFFEAF3F8),
                borderRadius: BorderRadius.circular(AppRadius.full),
                border: Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                peer.isNotEmpty ? peer[0] : 'U',
                style: GoogleFonts.sourceSans3(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _isWorker ? AppColors.onPrimary : AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    peer,
                    style: GoogleFonts.sourceSans3(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${widget.orderCode} · ${widget.orderStatus}',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: widget.isClosed ? null : _navigateToCall,
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: widget.isClosed ? AppColors.border.withValues(alpha: 0.5) : AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(
                    color: widget.isClosed ? AppColors.border : AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
                child: Icon(
                  Icons.phone_outlined,
                  size: 19,
                  color: widget.isClosed ? AppColors.textMuted : AppColors.primary,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Column(
        children: [
          const ChatPrivacyBanner(),
          Expanded(
            child: ListView.builder(
              key: const Key('chat_message_list'),
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                          bottomLeft: Radius.circular(6),
                        ),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildDot(),
                          const SizedBox(width: 4),
                          _buildDot(),
                          const SizedBox(width: 4),
                          _buildDot(),
                        ],
                      ),
                    ),
                  );
                }

                final msg = _messages[index];
                final isMine = _isWorker
                    ? msg.sender == ChatSender.worker
                    : msg.sender == ChatSender.customer;

                return ChatMessageBubble(
                  message: msg,
                  isMine: isMine,
                  isWorker: _isWorker,
                  isReadonly: widget.isClosed,
                  onCallBack: _navigateToCall,
                  onApproveExtraCost: () => _handleApproveExtraCost(index),
                  onDeclineExtraCost: () => _handleDeclineExtraCost(index),
                );
              },
            ),
          ),
          if (!widget.isClosed)
            ChatQuickRepliesBar(
              isWorker: _isWorker,
              onSelect: _sendMessage,
            ),
          ChatInputBar(
            controller: _textController,
            isClosed: widget.isClosed,
            onSend: () => _sendMessage(_textController.text),
            onAddPhoto: _addPhotoMessage,
            onAddLocation: _addLocationMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.textMuted,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
