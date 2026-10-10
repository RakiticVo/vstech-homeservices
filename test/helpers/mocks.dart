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
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart';
import 'package:vstech_home_services/features/home/data/datasources/category_remote_data_source.dart';
import 'package:vstech_home_services/features/home/domain/repositories/category_repository.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_categories_use_case.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_category_use_case.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/categories_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/category_detail_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:vstech_home_services/features/tracking/data/datasources/technician_location_remote_data_source.dart';
import 'package:vstech_home_services/features/tracking/domain/usecases/update_technician_location_use_case.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/bloc/worker_presence_cubit.dart';

// --- core ---
class MockAuthTokenStore extends Mock implements AuthTokenStore;

class MockHttpClientAdapter extends Mock implements HttpClientAdapter;

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage;

class MockApiClient extends Mock implements ApiClient;

class MockSessionCubit extends MockCubit<SessionState> implements SessionCubit;

// --- auth: data/domain ---
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource;

class MockProfileRemoteDataSource extends Mock implements ProfileRemoteDataSource;

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

class MockRegisterCubit extends MockCubit<AuthFormState> implements RegisterCubit;

class MockLogoutCubit extends MockCubit<LogoutState> implements LogoutCubit;

class MockProfileCubit extends MockCubit<ProfileState> implements ProfileCubit;

class MockLocationService extends Mock implements LocationService;

// --- categories ---
class MockCategoryRemoteDataSource extends Mock implements CategoryRemoteDataSource;

class MockCategoryRepository extends Mock implements CategoryRepository;

class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase;

class MockGetCategoryUseCase extends Mock implements GetCategoryUseCase;

class MockCategoriesCubit extends MockCubit<CategoriesState> implements CategoriesCubit;

class MockCategoryDetailCubit extends MockCubit<CategoryDetailState> implements CategoryDetailCubit;

// --- bookings ---
class MockBookingRemoteDataSource extends Mock implements BookingRemoteDataSource;

class MockBookingRepository extends Mock implements BookingRepository;

class MockEstimatePriceUseCase extends Mock implements EstimatePriceUseCase;

class MockCreateBookingUseCase extends Mock implements CreateBookingUseCase;

class MockGetMyBookingsUseCase extends Mock implements GetMyBookingsUseCase;

class MockGetBookingUseCase extends Mock implements GetBookingUseCase;

class MockCancelBookingUseCase extends Mock implements CancelBookingUseCase;

class MockDisputeBookingUseCase extends Mock implements DisputeBookingUseCase;

class MockBookingFlowBloc extends MockBloc<BookingFlowEvent, BookingFlowState> implements BookingFlowBloc;

class MockBookingListCubit extends MockCubit<BookingListState> implements BookingListCubit;

class MockOrderDetailCubit extends MockCubit<OrderDetailState> implements OrderDetailCubit;

class MockBookingActionCubit extends MockCubit<BookingActionState> implements BookingActionCubit;

// --- worker presence / GPS ---
class MockTechnicianLocationRemoteDataSource extends Mock implements TechnicianLocationRemoteDataSource;

class MockUpdateTechnicianLocationUseCase extends Mock implements UpdateTechnicianLocationUseCase;

class MockWorkerPresenceCubit extends MockCubit<WorkerPresenceState> implements WorkerPresenceCubit;
