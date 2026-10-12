import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';

final bookingUnread = AppNotification(
  id: '101',
  type: NotificationType.booking,
  title: 'Thợ đã nhận việc',
  body: 'Đơn #502 đã có thợ nhận',
  createdAt: DateTime.now().toUtc(),
);

final systemRead = AppNotification(
  id: '102',
  type: NotificationType.system,
  title: 'Bảo trì hệ thống',
  body: 'Tối nay 23:00',
  isRead: true,
  createdAt: DateTime.utc(2026, 9, 20, 3),
);

const promoUnread = AppNotification(
  id: '103',
  type: NotificationType.promo,
  title: 'Ưu đãi tháng 10',
);
