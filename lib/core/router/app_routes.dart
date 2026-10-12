/// Route name/path constants (kebab-case paths per CLAUDE.md naming conventions).
/// Feature modules add their own route constants here as they're scaffolded.
abstract final class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String intro = '/intro';
  static const String roleGateway = '/role-gateway';

  // --- auth ---
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String resetPasswordSuccess = '/auth/reset-password/success';

  /// OTP step location. [otpContext] is `register`, `login` or `forgot`; [role] is `customer` or
  /// `worker` (decides where a verified login/register continues).
  static String verifyOtpLocation({
    required String phone,
    required String role,
    required String otpContext,
  }) =>
      '$verifyOtp?phone=${Uri.encodeComponent(phone)}&role=$role&context=$otpContext';

  // --- customer home & categories ---
  static const String customerHome = '/customer/home';
  static const String categories = '/customer/categories';
  static const String serviceDetail = '/customer/service-detail';

  // --- worker experience ---
  static const String workerDashboard = '/worker/dashboard';
  static const String workerJobDetail = '/worker/job-detail';
  static String workerJobDetailLocation(String bookingId) =>
      '$workerJobDetail?id=${Uri.encodeComponent(bookingId)}';
  static const String workerKyc = '/worker/kyc';
  static const String workerKycStatus = '/worker/kyc-status';

  // --- customer booking & dispatch matching ---
  static const String bookingStep1 = '/customer/booking/step-1';

  /// Step 1 of the booking flow for one service category.
  static String bookingStep1Location({required String categoryId}) =>
      '$bookingStep1?categoryId=${Uri.encodeComponent(categoryId)}';
  static const String bookingStep2 = '/customer/booking/step-2';
  static const String bookingStep3 = '/customer/booking/step-3';
  static const String bookingSuccess = '/customer/booking/success';
  static const String bookingMatching = '/customer/booking/matching';

  // --- tracking & real-time progress (Batch 6) ---
  static const String customerTracking = '/customer/tracking';
  static const String workerEnRoute = '/worker/job-en-route';
  static String workerEnRouteLocation(String bookingId) =>
      '$workerEnRoute?id=${Uri.encodeComponent(bookingId)}';
  static const String workerArrived = '/worker/job-arrived';
  static String workerArrivedLocation(String bookingId) =>
      '$workerArrived?id=${Uri.encodeComponent(bookingId)}';
  static const String workerExecuting = '/worker/job-executing';
  static String workerExecutingLocation(String bookingId) =>
      '$workerExecuting?id=${Uri.encodeComponent(bookingId)}';

  // --- checkout, inspection, payment & review (Batch 7) ---
  static const String inspectionSignoff = '/customer/order/inspect';
  static const String orderPaymentSummary = '/customer/order/payment';
  static const String paymentGateway = '/customer/order/pay';
  static const String paymentSuccess = '/customer/order/paid';
  static const String electronicReceipt = '/customer/order/receipt';
  static const String orderReviewTip = '/customer/order/review';
  static const String orderThanks = '/customer/order/thanks';
  static const String workerJobCompletion = '/worker/job-completion';

  // --- orders hub & notifications (Batch 8) ---
  static const String customerOrders = '/customer/orders';
  static const String customerOrderDetail = '/customer/orders/detail';
  static String customerOrderDetailLocation(String bookingId) =>
      '$customerOrderDetail?id=${Uri.encodeComponent(bookingId)}';
  static const String workerJobsHub = '/worker/jobs';
  static const String customerNotifications = '/customer/notifications';
  static const String customerNotificationSettings =
      '/customer/settings/notifications';
  static const String workerNotifications = '/worker/notifications';

  // --- exceptions, cancellation & escrow dispute (Batch 9) ---
  static const String customerCancel = '/customer/booking/cancel';
  static String customerCancelLocation(String bookingId) =>
      '$customerCancel?id=${Uri.encodeComponent(bookingId)}';
  static const String workerCancel = '/worker/job/cancel';
  static const String customerNoShow = '/worker/job/no-show';
  static const String disputeReport = '/customer/order/dispute';
  static String disputeReportLocation(String bookingId) =>
      '$disputeReport?id=${Uri.encodeComponent(bookingId)}';
  static const String orderDisputed = '/customer/order/disputed';
  static const String customerDisputeList = '/customer/disputes';
  static const String disputeDetail = '/customer/disputes/detail';
  static const String workerDisputeNotification = '/worker/job/dispute';

  // --- auto-warranty journey (Batch 10) ---
  static const String warrantyCertificate = '/customer/warranty/certificate';
  static const String warrantyRequest = '/customer/warranty/request';
  static const String warrantyStatus = '/customer/warranty/status';
  static const String workerWarrantyJob = '/worker/job/warranty';
  static const String workerWarrantyDecline = '/worker/job/warranty-decline';

  // --- messaging & masked voip calls (Batch 11) ---
  static const String chat = '/messaging/chat';
  static const String voipCall = '/messaging/call';

  // --- devices, ai assistant & customer profile (Batch 12) ---
  static const String myHomeDevices = '/customer/devices';
  static const String aiAssistant = '/customer/ai-chat';
  static const String aiSuggestions = '/customer/ai-suggestions';
  static const String customerProfile = '/customer/profile';
  static const String editProfile = '/customer/profile/edit';
  static const String myAddresses = '/customer/addresses';
  static const String editAddress = '/customer/addresses/edit';
  static const String paymentMethods = '/customer/payment-methods';
  static const String linkWallet = '/customer/payment-methods/link';
  static const String favouritePros = '/customer/favourites';
  static const String workerProfilePreview = '/customer/workers/preview';
  static const String customerSettings = '/customer/settings';
  static const String changePassword = '/customer/change-password';
  static const String deleteAccount = '/customer/delete-account';

  // --- worker wallet, schedule & operations (Batch 13) ---
  static const String workerWallet = '/worker/wallet';
  static const String workerTransactionDetail =
      '/worker/wallet/transaction-detail';
  static String workerTransactionDetailLocation(String transactionId) =>
      '$workerTransactionDetail?id=${Uri.encodeComponent(transactionId)}';
  static const String workerWithdraw = '/worker/wallet/withdraw';
  static const String workerWithdrawPin = '/worker/wallet/withdraw/pin';
  static const String workerWithdrawStatus = '/worker/wallet/withdraw/status';
  static String workerWithdrawStatusLocation(String withdrawalId) =>
      '$workerWithdrawStatus?id=${Uri.encodeComponent(withdrawalId)}';
  static const String workerSchedule = '/worker/schedule';
  static const String workerAvailability = '/worker/schedule/availability';
  static const String workerWorkZone = '/worker/profile/zone';
  static const String workerSkills = '/worker/profile/skills';
  static const String workerUploadCert = '/worker/profile/upload-cert';
  static const String workerPerformance = '/worker/profile/performance';
  static const String workerProfile = '/worker/profile';
}
