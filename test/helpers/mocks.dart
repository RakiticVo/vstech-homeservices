import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vstech_home_services/features/auth/data/datasources/profile_remote_data_source.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/auth_repository.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/credentials_repository.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/profile_repository.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/login_use_case.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/logout_use_case.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/register_use_case.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/login_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/logout_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/profile_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/register_cubit.dart';
import 'package:vstech_home_services/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/change_booking_status_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/estimate_price_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_booking_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_my_bookings_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/worker_booking_use_cases.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart';
import 'package:vstech_home_services/features/home/data/datasources/category_remote_data_source.dart';
import 'package:vstech_home_services/features/home/domain/repositories/category_repository.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_categories_use_case.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_category_use_case.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/categories_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/category_detail_cubit.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/chat_remote_data_source.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/chat_socket_data_source.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/voip_remote_data_source.dart';
import 'package:vstech_home_services/features/messaging/domain/repositories/chat_repository.dart';
import 'package:vstech_home_services/features/messaging/domain/repositories/voip_repository.dart';
import 'package:vstech_home_services/features/messaging/domain/usecases/chat_use_cases.dart';
import 'package:vstech_home_services/features/messaging/domain/usecases/voip_use_cases.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/chat_cubit.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/voip_call_cubit.dart';
import 'package:vstech_home_services/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:vstech_home_services/features/notifications/domain/repositories/notification_repository.dart';
import 'package:vstech_home_services/features/notifications/domain/usecases/notification_use_cases.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notification_settings_cubit.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:vstech_home_services/features/tracking/data/datasources/technician_location_remote_data_source.dart';
import 'package:vstech_home_services/features/tracking/domain/repositories/tracking_connection.dart';
import 'package:vstech_home_services/features/tracking/domain/usecases/update_technician_location_use_case.dart';
import 'package:vstech_home_services/features/tracking/presentation/bloc/customer_tracking_cubit.dart';
import 'package:vstech_home_services/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:vstech_home_services/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:vstech_home_services/features/wallet/domain/usecases/wallet_use_cases.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/transaction_detail_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/wallet_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdraw_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdrawal_status_cubit.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/bloc/worker_presence_cubit.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/quote_form_cubit.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/worker_task_cubit.dart';

// --- core ---
class MockAuthTokenStore extends Mock implements AuthTokenStore;

class MockHttpClientAdapter extends Mock implements HttpClientAdapter;

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage;

class MockApiClient extends Mock implements ApiClient;

class MockSessionCubit extends MockCubit<SessionState> implements SessionCubit;

// --- auth: data/domain ---
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource;

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource;

class MockAuthRepository extends Mock implements AuthRepository;

class MockProfileRepository extends Mock implements ProfileRepository;

class MockCredentialsRepository extends Mock implements CredentialsRepository;

class MockLoginUseCase extends Mock implements LoginUseCase;

class MockRegisterUseCase extends Mock implements RegisterUseCase;

class MockLogoutUseCase extends Mock implements LogoutUseCase;

class MockGetProfileUseCase extends Mock implements GetProfileUseCase;

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase;

// --- auth: presentation ---
class MockLoginCubit extends MockCubit<AuthFormState> implements LoginCubit;

class MockRegisterCubit extends MockCubit<AuthFormState>
    implements RegisterCubit;

class MockLogoutCubit extends MockCubit<LogoutState> implements LogoutCubit;

class MockProfileCubit extends MockCubit<ProfileState> implements ProfileCubit;

class MockLocationService extends Mock implements LocationService;

// --- categories ---
class MockCategoryRemoteDataSource extends Mock
    implements CategoryRemoteDataSource;

class MockCategoryRepository extends Mock implements CategoryRepository;

class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase;

class MockGetCategoryUseCase extends Mock implements GetCategoryUseCase;

class MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit;

class MockCategoryDetailCubit extends MockCubit<CategoryDetailState>
    implements CategoryDetailCubit;

// --- bookings ---
class MockBookingRemoteDataSource extends Mock
    implements BookingRemoteDataSource;

class MockBookingRepository extends Mock implements BookingRepository;

class MockEstimatePriceUseCase extends Mock implements EstimatePriceUseCase;

class MockCreateBookingUseCase extends Mock implements CreateBookingUseCase;

class MockGetMyBookingsUseCase extends Mock implements GetMyBookingsUseCase;

class MockGetBookingUseCase extends Mock implements GetBookingUseCase;

class MockCancelBookingUseCase extends Mock implements CancelBookingUseCase;

class MockDisputeBookingUseCase extends Mock implements DisputeBookingUseCase;

class MockBookingFlowBloc extends MockBloc<BookingFlowEvent, BookingFlowState>
    implements BookingFlowBloc;

class MockBookingListCubit extends MockCubit<BookingListState>
    implements BookingListCubit;

class MockOrderDetailCubit extends MockCubit<OrderDetailState>
    implements OrderDetailCubit;

class MockBookingActionCubit extends MockCubit<BookingActionState>
    implements BookingActionCubit;

// --- worker presence / GPS ---
class MockTechnicianLocationRemoteDataSource extends Mock
    implements TechnicianLocationRemoteDataSource;

class MockUpdateTechnicianLocationUseCase extends Mock
    implements UpdateTechnicianLocationUseCase;

class MockWorkerPresenceCubit extends MockCubit<WorkerPresenceState>
    implements WorkerPresenceCubit;

// --- worker task ---
class MockAcceptBookingUseCase extends Mock implements AcceptBookingUseCase;

class MockStartBookingUseCase extends Mock implements StartBookingUseCase;

class MockSubmitQuoteUseCase extends Mock implements SubmitQuoteUseCase;

class MockGetSubmittedQuoteUseCase extends Mock
    implements GetSubmittedQuoteUseCase;

class MockQuoteFormCubit extends MockCubit<QuoteFormState>
    implements QuoteFormCubit;

class MockCompleteBookingUseCase extends Mock implements CompleteBookingUseCase;

class MockWorkerTaskCubit extends MockCubit<WorkerTaskState>
    implements WorkerTaskCubit;

// --- wallet ---
class MockWalletRemoteDataSource extends Mock implements WalletRemoteDataSource;

class MockWalletRepository extends Mock implements WalletRepository;

class MockGetWalletUseCase extends Mock implements GetWalletUseCase;

class MockGetTransactionsUseCase extends Mock implements GetTransactionsUseCase;

class MockCreateWithdrawalUseCase extends Mock
    implements CreateWithdrawalUseCase;

class MockGetWithdrawalUseCase extends Mock implements GetWithdrawalUseCase;

class MockGetTransactionUseCase extends Mock implements GetTransactionUseCase;

class MockWalletCubit extends MockCubit<WalletState> implements WalletCubit;

class MockTransactionDetailCubit extends MockCubit<TransactionDetailState>
    implements TransactionDetailCubit;

class MockWithdrawCubit extends MockCubit<WithdrawState>
    implements WithdrawCubit;

class MockWithdrawalStatusCubit extends MockCubit<WithdrawalStatusState>
    implements WithdrawalStatusCubit;

// --- notifications ---
class MockNotificationRemoteDataSource extends Mock
    implements NotificationRemoteDataSource;

class MockNotificationRepository extends Mock implements NotificationRepository;

class MockGetNotificationsUseCase extends Mock
    implements GetNotificationsUseCase;

class MockMarkNotificationReadUseCase extends Mock
    implements MarkNotificationReadUseCase;

class MockMarkAllNotificationsReadUseCase extends Mock
    implements MarkAllNotificationsReadUseCase;

class MockNotificationsCubit extends MockCubit<NotificationsState>
    implements NotificationsCubit;

class MockGetNotificationSettingsUseCase extends Mock
    implements GetNotificationSettingsUseCase;

class MockUpdateNotificationSettingsUseCase extends Mock
    implements UpdateNotificationSettingsUseCase;

class MockNotificationSettingsCubit extends MockCubit<NotificationSettingsState>
    implements NotificationSettingsCubit;

// --- chat ---
class MockChatRemoteDataSource extends Mock implements ChatRemoteDataSource;

class MockChatSocketDataSource extends Mock implements ChatSocketDataSource;

class MockChatRepository extends Mock implements ChatRepository;

class MockChatConnection extends Mock implements ChatConnection;

class MockOpenChatRoomUseCase extends Mock implements OpenChatRoomUseCase;

class MockGetChatMessagesUseCase extends Mock implements GetChatMessagesUseCase;

class MockSendChatMessageUseCase extends Mock implements SendChatMessageUseCase;

class MockChatCubit extends MockCubit<ChatState> implements ChatCubit;

// --- voip ---
class MockVoipRemoteDataSource extends Mock implements VoipRemoteDataSource;

class MockVoipRepository extends Mock implements VoipRepository;

class MockStartBookingCallUseCase extends Mock
    implements StartBookingCallUseCase;

class MockEndCallUseCase extends Mock implements EndCallUseCase;

class MockGetCallHistoryUseCase extends Mock implements GetCallHistoryUseCase;

class MockVoipCallCubit extends MockCubit<VoipCallState>
    implements VoipCallCubit;

// --- customer tracking ---
class MockTrackingConnection extends Mock implements TrackingConnection;

class MockCustomerTrackingCubit extends MockCubit<CustomerTrackingState>
    implements CustomerTrackingCubit;
