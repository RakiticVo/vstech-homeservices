/// All API endpoint path constants, matching `docs/api/openapi.yaml` — never inline a path
/// literal in a datasource. Path params are built with the helper functions below.
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
  static String serviceCategory(int id) => '$serviceCategories/$id';

  // --- Bookings & quotes ---
  static const String bookings = '$apiVersion/bookings';
  static const String bookingEstimate = '$bookings/estimate';
  static String bookingAccept(int id) => '$bookings/$id/accept';
  static String bookingStart(int id) => '$bookings/$id/start';
  static String bookingComplete(int id) => '$bookings/$id/complete';
  static String bookingCancel(int id) => '$bookings/$id/cancel';
  static String bookingDispute(int id) => '$bookings/$id/dispute';
  static String bookingQuote(int id) => '$bookings/$id/quote';
  static String bookingQuoteApprove(int id) => '$bookings/$id/quote/approve';
  static String bookingQuoteReject(int id) => '$bookings/$id/quote/reject';

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
  static String notificationRead(int id) => '$notifications/$id/read';

  // --- Chat ---
  static const String chatRooms = '$apiVersion/chat/rooms';
  static String chatMessages(int roomId) => '$chatRooms/$roomId/messages';

  // --- VoIP call log ---
  static const String voipCalls = '$apiVersion/voip/calls';
  static const String voipCallsEnd = '$voipCalls/end';

  // --- WebSocket paths (relative to AppEnv.wsBaseUrl) ---
  static String wsChat(int roomId) => '/ws/chat/$roomId';
  static const String wsTracking = '/ws/tracking';
  static const String wsTrackingCustomer = '/ws/tracking/customer';
  static const String wsDispatch = '/ws/dispatch';
}
