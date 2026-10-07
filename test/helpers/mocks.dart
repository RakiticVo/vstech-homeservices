import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vstech_home_services/features/auth/data/datasources/profile_remote_data_source.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/auth_repository.dart';
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
