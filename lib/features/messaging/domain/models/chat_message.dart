/// Message sender role.
enum ChatSender {
  customer,
  worker,
  system,
}

/// Message type discriminator.
enum ChatMessageType {
  text,
  photo,
  location,
  extraCost,
  systemEvent,
  missedCall,
  callLog,
}

/// Approval status for in-chat change order / extra cost request.
enum ExtraCostStatus {
  pending,
  approved,
  declined,
}

/// In-app chat message entity for VSTech Home Services (Concept 02, Cells 80–84).
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sender,
    required this.type,
    required this.textVi,
    required this.textEn,
    required this.time,
    this.seen = false,
    this.isMasked = false,
    this.extraCostStatus = ExtraCostStatus.pending,
    this.extraCostAmount = 45000,
    this.photoUrl,
    this.callDuration,
  });

  final String id;
  final ChatSender sender;
  final ChatMessageType type;
  final String textVi;
  final String textEn;
  final String time;
  final bool seen;
  final bool isMasked;
  final ExtraCostStatus extraCostStatus;
  final int extraCostAmount;
  final String? photoUrl;
  final String? callDuration;

  ChatMessage copyWith({
    String? id,
    ChatSender? sender,
    ChatMessageType? type,
    String? textVi,
    String? textEn,
    String? time,
    bool? seen,
    bool? isMasked,
    ExtraCostStatus? extraCostStatus,
    int? extraCostAmount,
    String? photoUrl,
    String? callDuration,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      type: type ?? this.type,
      textVi: textVi ?? this.textVi,
      textEn: textEn ?? this.textEn,
      time: time ?? this.time,
      seen: seen ?? this.seen,
      isMasked: isMasked ?? this.isMasked,
      extraCostStatus: extraCostStatus ?? this.extraCostStatus,
      extraCostAmount: extraCostAmount ?? this.extraCostAmount,
      photoUrl: photoUrl ?? this.photoUrl,
      callDuration: callDuration ?? this.callDuration,
    );
  }
}
