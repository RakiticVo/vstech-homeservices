import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';

/// Customer profile id is '9' (see auth fixtures), the worker is '8821'.
const chatRoom = ChatRoom(
  id: '12345',
  bookingId: '502',
  customerId: '9',
  workerId: '8821',
);

final workerHello = ChatRoomMessage(
  id: '1',
  senderId: '8821',
  text: 'Chào chị, em là thợ phụ trách',
  sentAt: DateTime.utc(2026, 10, 11, 3),
);

final customerReply = ChatRoomMessage(
  id: '2',
  senderId: '9',
  text: 'Gọi chị 0901 234 567 nhé',
  isRead: true,
  sentAt: DateTime.utc(2026, 10, 11, 3, 1),
);

final workerLive = ChatRoomMessage(
  id: '3',
  senderId: '8821',
  text: 'Em tới rồi',
  sentAt: DateTime.utc(2026, 10, 11, 3, 5),
);

final missedCall = VoipCall(
  id: '70',
  bookingId: '502',
  callerId: '9',
  receiverId: '8821',
  durationSeconds: 0,
  startedAt: DateTime.utc(2026, 10, 11, 3, 2),
  endedAt: DateTime.utc(2026, 10, 11, 3, 2, 30),
);

final talkedCall = VoipCall(
  id: '71',
  bookingId: '502',
  callerId: '8821',
  receiverId: '9',
  durationSeconds: 48,
  startedAt: DateTime.utc(2026, 10, 11, 3, 4),
  endedAt: DateTime.utc(2026, 10, 11, 3, 4, 48),
);
