/// All API endpoint path constants, matching `docs/api/openapi.yaml` — never inline a path
/// literal in a datasource. Path params are built with the helper functions below; ids are strings
/// because the module docs use UUIDs while the OpenAPI spec says int64.
/// Admin-only endpoints (withdrawal approval, manual dispatch, category CRUD, VoIP recordings)
/// and post-MVP `/assets` are intentionally absent.
abstract final class ApiEndpoints {
  static const String apiVersion = '/api/v1';

  // --- Auth & Profiles ---
  static const String authRegister = '$apiVersion/auth/register';
  static const String authLogin = '$apiVersion/auth/login';
  static const String authRefresh = '$apiVersion/auth/refresh';
  static const String authLogout = '$apiVersion/auth/logout';
  static const String profiles = '$apiVersion/profiles';

  // --- Devices (FCM) ---
  static const String devicesRegister = '$apiVersion/devices/register';
  static const String devices = '$apiVersion/devices';

  // --- Service categories ---
  static const String serviceCategories = '$apiVersion/service-categories';
  static String serviceCategory(String id) => '$serviceCategories/$id';

  // --- Bookings & quotes ---
  static const String bookings = '$apiVersion/bookings';
  static const String bookingEstimate = '$bookings/estimate';
  static String bookingAccept(String id) => '$bookings/$id/accept';
  static String bookingStart(String id) => '$bookings/$id/start';
  static String bookingComplete(String id) => '$bookings/$id/complete';
  static String bookingCancel(String id) => '$bookings/$id/cancel';
  static String bookingDispute(String id) => '$bookings/$id/dispute';
  static String bookingQuote(String id) => '$bookings/$id/quote';
  static String bookingQuoteApprove(String id) => '$bookings/$id/quote/approve';
  static String bookingQuoteReject(String id) => '$bookings/$id/quote/reject';

  // --- Technician location ---
  static const String technicianLocation = '$apiVersion/technician/location';

  // --- Wallet, payments & withdrawals ---
  static const String walletMe = '$apiVersion/wallets/me';
  static const String walletTransactions = '$walletMe/transactions';
  static const String paymentDeposit = '$apiVersion/wallets/payments/deposit';
  static const String paymentWithdraw = '$apiVersion/wallets/payments/withdraw';
  static const String withdrawals = '$apiVersion/wallets/withdrawals';

  // --- Notifications ---
  static const String notifications = '$apiVersion/notifications';
  static const String notificationsReadAll = '$notifications/read-all';
  static const String notificationSettings = '$notifications/settings';
  static String notificationRead(String id) => '$notifications/$id/read';

  // --- Chat ---
  static const String chatRooms = '$apiVersion/chat/rooms';
  static String chatMessages(String roomId) => '$chatRooms/$roomId/messages';

  // --- VoIP call log ---
  static const String voipCalls = '$apiVersion/voip/calls';
  static const String voipCallsEnd = '$voipCalls/end';

  // --- WebSocket paths (relative to AppEnv.wsBaseUrl) ---
  static String wsChat(String roomId) => '/ws/chat/$roomId';
  static const String wsTracking = '/ws/tracking';
  static const String wsTrackingCustomer = '/ws/tracking/customer';
  static const String wsDispatch = '/ws/dispatch';
}
