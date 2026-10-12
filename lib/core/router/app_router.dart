import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/di/injection.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/router/go_router_refresh_stream.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/login_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/logout_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/profile_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/register_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/splash_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/change_password_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/customer_profile_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/customer_settings_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/delete_account_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/edit_address_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/edit_profile_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/intro_value_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/link_wallet_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/login_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/my_addresses_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/onboarding_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/payment_methods_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/register_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/reset_password_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/reset_password_success_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/role_gateway_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/splash_page.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step1_service_option_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step2_schedule_address_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step3_confirm_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_success_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/dispatch_radar_matching_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/electronic_receipt_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/inspection_signoff_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/order_payment_summary_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/order_review_tip_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/order_thanks_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/payment_gateway_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/payment_success_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/worker_job_completion_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_cancellation_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_dispute_list_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_no_show_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/dispute_detail_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/dispute_report_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/order_disputed_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/worker_cancellation_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/worker_dispute_notification_page.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/categories_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/category_detail_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/pages/ai_assistant_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/ai_suggestions_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/categories_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/customer_home_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/favourite_pros_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/my_home_devices_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/service_detail_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/worker_profile_preview_page.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/chat_cubit.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/voip_call_cubit.dart';
import 'package:vstech_home_services/features/messaging/presentation/pages/chat_page.dart';
import 'package:vstech_home_services/features/messaging/presentation/pages/voip_call_page.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notification_settings_cubit.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:vstech_home_services/features/notifications/presentation/pages/notification_settings_page.dart';
import 'package:vstech_home_services/features/notifications/presentation/pages/notifications_page.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_order_detail_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_orders_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/worker_jobs_hub_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/customer_tracking_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_arrived_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_en_route_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_executing_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/transaction_detail_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/wallet_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdraw_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdrawal_status_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_transaction_detail_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_wallet_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_pin_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_status_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/warranty_certificate_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/warranty_request_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/warranty_status_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/worker_warranty_decline_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/worker_warranty_job_detail_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/bloc/worker_presence_cubit.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_availability_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_dashboard_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_performance_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_profile_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_schedule_week_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_skills_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_upload_cert_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_work_zone_page.dart';
import 'package:vstech_home_services/features/worker_dispatch/presentation/pages/worker_job_detail_page.dart';
import 'package:vstech_home_services/features/worker_kyc/presentation/pages/worker_kyc_status_page.dart';
import 'package:vstech_home_services/features/worker_kyc/presentation/pages/worker_kyc_wizard_page.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/worker_task_cubit.dart';

/// Root GoRouter config. Auth guards belong here as `redirect` callbacks — never as
/// widget-level conditions (see CLAUDE.md Authentication rules). Route-level BLoCs are wrapped
/// with `BlocProvider` inside each route's `builder`, not at the app root.
GoRouter createAppRouter({required SessionCubit session}) => GoRouter(
  initialLocation: AppRoutes.splash,
  refreshListenable: GoRouterRefreshStream(session.stream),
  redirect: (context, state) =>
      sessionRedirect(session.state, state.matchedLocation),
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<SplashCubit>(),
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.intro,
      builder: (context, state) => const IntroValuePage(),
    ),
    GoRoute(
      path: AppRoutes.roleGateway,
      builder: (context, state) => const RoleGatewayPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) {
        final role = state.uri.queryParameters['role'] ?? 'customer';
        return BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: LoginPage(initialRole: role),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) {
        final role = state.uri.queryParameters['role'] ?? 'customer';
        return BlocProvider(
          create: (_) => getIt<RegisterCubit>(),
          child: RegisterPage(initialRole: role),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.verifyOtp,
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '0901 234 567';
        final role = state.uri.queryParameters['role'] ?? 'customer';
        final otpContext = state.uri.queryParameters['context'] ?? 'register';
        return OtpVerificationPage(
          phone: phone,
          role: role,
          otpContext: otpContext,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) {
        final role = state.uri.queryParameters['role'] ?? 'customer';
        final phone = state.uri.queryParameters['phone'] ?? '';
        return ForgotPasswordPage(role: role, phone: phone);
      },
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) => ResetPasswordPage(
        role: state.uri.queryParameters['role'] ?? 'customer',
      ),
    ),
    GoRoute(
      path: AppRoutes.resetPasswordSuccess,
      builder: (context, state) => ResetPasswordSuccessPage(
        role: state.uri.queryParameters['role'] ?? 'customer',
      ),
    ),
    GoRoute(
      path: AppRoutes.customerHome,
      builder: (context, state) => _withCategories(const CustomerHomePage()),
    ),
    GoRoute(
      path: AppRoutes.categories,
      builder: (context, state) => _withCategories(const CategoriesPage()),
    ),
    GoRoute(
      path: AppRoutes.serviceDetail,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CategoryDetailCubit>(),
        child: ServiceDetailPage(
          serviceId: state.uri.queryParameters['id'] ?? '',
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.workerDashboard,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<WorkerPresenceCubit>()),
          BlocProvider(create: (_) => _loadedBookingList()),
        ],
        child: const WorkerDashboardPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.workerJobDetail,
      builder: (context, state) =>
          _withWorkerTask(WorkerJobDetailPage(bookingId: _bookingId(state))),
    ),
    GoRoute(
      path: AppRoutes.workerKyc,
      builder: (context, state) {
        final step =
            int.tryParse(state.uri.queryParameters['step'] ?? '2') ?? 2;
        return WorkerKycWizardPage(initialStep: step);
      },
    ),
    GoRoute(
      path: AppRoutes.workerKycStatus,
      builder: (context, state) {
        final status = state.uri.queryParameters['status'] ?? 'pending';
        return WorkerKycStatusPage(initialStatus: status);
      },
    ),
    // One BookingFlowBloc shared by every step of the booking wizard (draft survives back/forward).
    ShellRoute(
      builder: (context, state, child) =>
          BlocProvider(create: (_) => getIt<BookingFlowBloc>(), child: child),
      routes: [
        GoRoute(
          path: AppRoutes.bookingStep1,
          builder: (context, state) => BookingStep1ServiceOptionPage(
            categoryId: state.uri.queryParameters['categoryId'] ?? '',
          ),
        ),
        GoRoute(
          path: AppRoutes.bookingStep2,
          builder: (context, state) => const BookingStep2ScheduleAddressPage(),
        ),
        GoRoute(
          path: AppRoutes.bookingStep3,
          builder: (context, state) => const BookingStep3ConfirmPage(),
        ),
        GoRoute(
          path: AppRoutes.bookingSuccess,
          builder: (context, state) => const BookingSuccessPage(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.bookingMatching,
      builder: (context, state) {
        final stage =
            int.tryParse(state.uri.queryParameters['stage'] ?? '0') ?? 0;
        final rematch = state.uri.queryParameters['rematch'] == 'true';
        return DispatchRadarMatchingPage(
          initialStage: stage,
          isWorkerCancelled: rematch,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.customerTracking,
      builder: (context, state) {
        final stage =
            int.tryParse(state.uri.queryParameters['stage'] ?? '1') ?? 1;
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return CustomerTrackingPage(initialStage: stage, orderCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.workerEnRoute,
      builder: (context, state) =>
          WorkerEnRoutePage(bookingId: _bookingId(state)),
    ),
    GoRoute(
      path: AppRoutes.workerArrived,
      builder: (context, state) =>
          _withWorkerTask(WorkerArrivedPage(bookingId: _bookingId(state))),
    ),
    GoRoute(
      path: AppRoutes.workerExecuting,
      builder: (context, state) =>
          _withWorkerTask(WorkerExecutingPage(bookingId: _bookingId(state))),
    ),
    GoRoute(
      path: AppRoutes.inspectionSignoff,
      builder: (context, state) {
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return InspectionSignoffPage(orderCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.orderPaymentSummary,
      builder: (context, state) {
        final labour =
            int.tryParse(state.uri.queryParameters['labour'] ?? '350000') ??
            350000;
        final addons =
            int.tryParse(state.uri.queryParameters['addons'] ?? '30000') ??
            30000;
        final premises =
            int.tryParse(state.uri.queryParameters['premises'] ?? '20000') ??
            20000;
        final extra =
            int.tryParse(state.uri.queryParameters['extra'] ?? '0') ?? 0;
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return OrderPaymentSummaryPage(
          labourFee: labour,
          addonsFee: addons,
          premisesFee: premises,
          extraMaterialFee: extra,
          orderCode: code,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.paymentGateway,
      builder: (context, state) {
        final amount =
            int.tryParse(state.uri.queryParameters['amount'] ?? '400000') ??
            400000;
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        final failed = state.uri.queryParameters['state'] == 'fail';
        return PaymentGatewayPage(
          amount: amount,
          orderCode: code,
          initialFailed: failed,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.paymentSuccess,
      builder: (context, state) {
        final amount =
            int.tryParse(state.uri.queryParameters['amount'] ?? '400000') ??
            400000;
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return PaymentSuccessPage(amount: amount, orderCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.electronicReceipt,
      builder: (context, state) {
        final amount =
            int.tryParse(state.uri.queryParameters['amount'] ?? '400000') ??
            400000;
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return ElectronicReceiptPage(amount: amount, orderCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.orderReviewTip,
      builder: (context, state) {
        final rating =
            int.tryParse(state.uri.queryParameters['rating'] ?? '5') ?? 5;
        final tip = int.tryParse(state.uri.queryParameters['tip'] ?? '0') ?? 0;
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return OrderReviewTipPage(
          initialRating: rating,
          initialTip: tip,
          orderCode: code,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.orderThanks,
      builder: (context, state) => const OrderThanksPage(),
    ),
    GoRoute(
      path: AppRoutes.workerJobCompletion,
      builder: (context, state) {
        final stage = state.uri.queryParameters['stage'] ?? 'inspection';
        final total =
            int.tryParse(state.uri.queryParameters['total'] ?? '400000') ??
            400000;
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        final extra =
            int.tryParse(state.uri.queryParameters['extra'] ?? '0') ?? 0;
        return WorkerJobCompletionPage(
          initialStage: stage,
          totalPrice: total,
          extraCost: extra,
          orderCode: code,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.customerOrders,
      builder: (context, state) {
        final tab = int.tryParse(state.uri.queryParameters['tab'] ?? '0') ?? 0;
        return BlocProvider(
          create: (_) => _loadedBookingList(),
          child: CustomerOrdersPage(initialTab: tab),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.customerOrderDetail,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<OrderDetailCubit>(),
          child: CustomerOrderDetailPage(
            bookingId: state.uri.queryParameters['id'] ?? '',
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.workerJobsHub,
      builder: (context, state) {
        final tab = int.tryParse(state.uri.queryParameters['tab'] ?? '0') ?? 0;
        return BlocProvider(
          create: (_) => _loadedBookingList(),
          child: WorkerJobsHubPage(initialTab: tab),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.customerNotifications,
      builder: (context, state) => _withNotifications(
        const NotificationsPage(
          isWorker: false,
          settingsRoute: AppRoutes.customerNotificationSettings,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.customerNotificationSettings,
      builder: (context, state) => _withNotificationSettings(),
    ),
    GoRoute(
      path: AppRoutes.workerNotifications,
      builder: (context, state) => _withNotifications(
        const NotificationsPage(
          isWorker: true,
          settingsRoute: AppRoutes.workerNotificationSettings,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.workerNotificationSettings,
      builder: (context, state) => _withNotificationSettings(),
    ),
    GoRoute(
      path: AppRoutes.customerCancel,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<BookingActionCubit>(),
          child: CustomerCancellationPage(
            bookingId: state.uri.queryParameters['id'] ?? '',
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.workerCancel,
      builder: (context, state) {
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return WorkerCancellationPage(jobCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.customerNoShow,
      builder: (context, state) {
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return CustomerNoShowPage(jobCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.disputeReport,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<BookingActionCubit>(),
          child: DisputeReportPage(
            bookingId: state.uri.queryParameters['id'] ?? '',
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.orderDisputed,
      builder: (context, state) {
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        final complaint =
            state.uri.queryParameters['complaint'] ?? '#KN-0425-031';
        return OrderDisputedPage(orderCode: code, complaintCode: complaint);
      },
    ),
    GoRoute(
      path: AppRoutes.customerDisputeList,
      builder: (context, state) => const CustomerDisputeListPage(),
    ),
    GoRoute(
      path: AppRoutes.disputeDetail,
      builder: (context, state) {
        final id = state.uri.queryParameters['id'] ?? '#KN-0228-014';
        final order = state.uri.queryParameters['order'] ?? 'HS-2026-0054';
        final needInfo = state.uri.queryParameters['needInfo'] == 'true';
        return DisputeDetailPage(
          complaintId: id,
          orderCode: order,
          isNeedInfo: needInfo,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.workerDisputeNotification,
      builder: (context, state) {
        final code = state.uri.queryParameters['code'] ?? 'HS-2026-0012';
        return WorkerDisputeNotificationPage(jobCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.warrantyCertificate,
      builder: (context, state) {
        final code = state.uri.queryParameters['code'] ?? 'HS-20250318-0087';
        final expired = state.uri.queryParameters['expired'] == 'true';
        final hasRequest = state.uri.queryParameters['hasRequest'] == 'true';
        return WarrantyCertificatePage(
          orderCode: code,
          isExpired: expired,
          hasExistingRequest: hasRequest,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.warrantyRequest,
      builder: (context, state) {
        final code = state.uri.queryParameters['code'] ?? 'HS-20250318-0087';
        return WarrantyRequestPage(orderCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.warrantyStatus,
      builder: (context, state) {
        final stage =
            int.tryParse(state.uri.queryParameters['stage'] ?? '1') ?? 1;
        return WarrantyStatusPage(stage: stage);
      },
    ),
    GoRoute(
      path: AppRoutes.workerWarrantyJob,
      builder: (context, state) {
        final code = state.uri.queryParameters['code'] ?? 'HS-20250318-0087';
        return WorkerWarrantyJobDetailPage(orderCode: code);
      },
    ),
    GoRoute(
      path: AppRoutes.workerWarrantyDecline,
      builder: (context, state) => const WorkerWarrantyDeclinePage(),
    ),
    GoRoute(
      path: AppRoutes.chat,
      builder: (context, state) {
        final bookingId = state.uri.queryParameters['id'] ?? '';
        return BlocProvider(
          create: (_) {
            final cubit = getIt<ChatCubit>();
            unawaited(cubit.open(bookingId));
            return cubit;
          },
          child: ChatPage(
            bookingId: bookingId,
            isWorker: state.uri.queryParameters['role'] == 'worker',
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.voipCall,
      builder: (context, state) {
        final bookingId = state.uri.queryParameters['id'] ?? '';
        final isWorker = state.uri.queryParameters['role'] == 'worker';
        return BlocProvider(
          create: (_) {
            final cubit = getIt<VoipCallCubit>();
            unawaited(cubit.start(bookingId, isWorker: isWorker));
            return cubit;
          },
          child: VoipCallPage(bookingId: bookingId, isWorker: isWorker),
        );
      },
    ),
    // --- Batch 12: Devices, AI Assistant & Account Settings ---
    GoRoute(
      path: AppRoutes.myHomeDevices,
      builder: (context, state) => const MyHomeDevicesPage(),
    ),
    GoRoute(
      path: AppRoutes.aiAssistant,
      builder: (context, state) => const AiAssistantPage(),
    ),
    GoRoute(
      path: AppRoutes.aiSuggestions,
      builder: (context, state) => const AiSuggestionsPage(),
    ),
    GoRoute(
      path: AppRoutes.customerProfile,
      builder: (context, state) => _withProfile(const CustomerProfilePage()),
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) => _withProfile(const EditProfilePage()),
    ),
    GoRoute(
      path: AppRoutes.myAddresses,
      builder: (context, state) => const MyAddressesPage(),
    ),
    GoRoute(
      path: AppRoutes.editAddress,
      builder: (context, state) => _withProfile(const EditAddressPage()),
    ),
    GoRoute(
      path: AppRoutes.paymentMethods,
      builder: (context, state) => const PaymentMethodsPage(),
    ),
    GoRoute(
      path: AppRoutes.linkWallet,
      builder: (context, state) => const LinkWalletPage(),
    ),
    GoRoute(
      path: AppRoutes.favouritePros,
      builder: (context, state) => const FavouriteProsPage(),
    ),
    GoRoute(
      path: AppRoutes.workerProfilePreview,
      builder: (context, state) => const WorkerProfilePreviewPage(),
    ),
    GoRoute(
      path: AppRoutes.customerSettings,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<LogoutCubit>(),
        child: const CustomerSettingsPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.changePassword,
      builder: (context, state) => const ChangePasswordPage(),
    ),
    GoRoute(
      path: AppRoutes.deleteAccount,
      builder: (context, state) => const DeleteAccountPage(),
    ),
    // --- Batch 13: Worker Wallet, Withdrawals, Schedule & Operations ---
    GoRoute(
      path: AppRoutes.workerWallet,
      builder: (context, state) => BlocProvider(
        create: (_) {
          final cubit = getIt<WalletCubit>();
          unawaited(cubit.load());
          return cubit;
        },
        child: const WorkerWalletPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.workerTransactionDetail,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<TransactionDetailCubit>(),
        child: WorkerTransactionDetailPage(transactionId: _bookingId(state)),
      ),
    ),
    // One WithdrawCubit shared by the amount/bank form and the PIN step.
    ShellRoute(
      builder: (context, state, child) =>
          BlocProvider(create: (_) => getIt<WithdrawCubit>(), child: child),
      routes: [
        GoRoute(
          path: AppRoutes.workerWithdraw,
          builder: (context, state) => const WorkerWithdrawPage(),
        ),
        GoRoute(
          path: AppRoutes.workerWithdrawPin,
          builder: (context, state) => const WorkerWithdrawPinPage(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.workerWithdrawStatus,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<WithdrawalStatusCubit>(),
        child: WorkerWithdrawStatusPage(withdrawalId: _bookingId(state)),
      ),
    ),
    GoRoute(
      path: AppRoutes.workerSchedule,
      builder: (context, state) => const WorkerScheduleWeekPage(),
    ),
    GoRoute(
      path: AppRoutes.workerAvailability,
      builder: (context, state) => const WorkerAvailabilityPage(),
    ),
    GoRoute(
      path: AppRoutes.workerWorkZone,
      builder: (context, state) => const WorkerWorkZonePage(),
    ),
    GoRoute(
      path: AppRoutes.workerSkills,
      builder: (context, state) => const WorkerSkillsPage(),
    ),
    GoRoute(
      path: AppRoutes.workerUploadCert,
      builder: (context, state) => const WorkerUploadCertPage(),
    ),
    GoRoute(
      path: AppRoutes.workerPerformance,
      builder: (context, state) => const WorkerPerformancePage(),
    ),
    GoRoute(
      path: AppRoutes.workerProfile,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<LogoutCubit>(),
        child: _withProfile(const WorkerProfilePage()),
      ),
    ),
  ],
);

/// `?id=` of an id-scoped route (booking, transaction, withdrawal).
String _bookingId(GoRouterState state) => state.uri.queryParameters['id'] ?? '';

/// Provides a fresh [WorkerTaskCubit]; the page loads its booking.
Widget _withNotificationSettings() => BlocProvider(
  create: (_) {
    final cubit = getIt<NotificationSettingsCubit>();
    unawaited(cubit.load());
    return cubit;
  },
  child: const NotificationSettingsPage(),
);

Widget _withNotifications(Widget page) => BlocProvider(
  create: (_) {
    final cubit = getIt<NotificationsCubit>();
    unawaited(cubit.load());
    return cubit;
  },
  child: page,
);

Widget _withWorkerTask(Widget page) =>
    BlocProvider(create: (_) => getIt<WorkerTaskCubit>(), child: page);

/// A [BookingListCubit] already loading `GET /bookings` (customer orders or worker jobs).
BookingListCubit _loadedBookingList() {
  final cubit = getIt<BookingListCubit>();
  unawaited(cubit.load());
  return cubit;
}

/// Provides a [CategoriesCubit] that starts loading `GET /service-categories` immediately.
Widget _withCategories(Widget page) => BlocProvider(
  create: (_) {
    final cubit = getIt<CategoriesCubit>();
    unawaited(cubit.load());
    return cubit;
  },
  child: page,
);

/// Provides a [ProfileCubit] that starts loading `GET /profiles` immediately.
Widget _withProfile(Widget page) => BlocProvider(
  create: (_) {
    final cubit = getIt<ProfileCubit>();
    unawaited(cubit.load());
    return cubit;
  },
  child: page,
);

/// Routes reachable without a session (splash, onboarding, auth flows).
bool isPublicLocation(String location) =>
    location == AppRoutes.splash ||
    location == AppRoutes.onboarding ||
    location == AppRoutes.intro ||
    location == AppRoutes.roleGateway ||
    location.startsWith('/auth/');

/// Landing screen for a signed-in [role].
String homeRouteFor(UserRole role) => role == UserRole.worker
    ? AppRoutes.workerDashboard
    : AppRoutes.customerHome;

/// Auth guard + role guard, evaluated on every navigation and whenever [SessionCubit] changes:
/// - signed out (or session expired) on a protected screen → login;
/// - signed in on onboarding/auth screens (except login/register/OTP, which navigate themselves) →
///   the role's home;
/// - a customer on `/worker/*` (or a worker on `/customer/*`) → the role's home.
/// While the role is still unknown (splash is fetching the profile) nothing is redirected.
String? sessionRedirect(SessionState session, String location) {
  switch (session) {
    case SessionInitialState():
      return null;
    case SessionUnauthenticatedState():
      return isPublicLocation(location) ? null : AppRoutes.login;
    case SessionAuthenticatedState(:final role):
      // Splash, login, register and the OTP step navigate on their own right after signing in
      // (register sends workers to KYC), so the guard must not race them.
      if (role == null ||
          const {
            AppRoutes.splash,
            AppRoutes.login,
            AppRoutes.register,
            AppRoutes.verifyOtp,
          }.contains(location)) {
        return null;
      }
      final home = homeRouteFor(role);
      if (isPublicLocation(location)) return home;
      final foreignPrefix = role == UserRole.worker ? '/customer/' : '/worker/';
      return location.startsWith(foreignPrefix) ? home : null;
  }
}
