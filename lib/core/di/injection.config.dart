// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:vstech_home_services/core/di/register_module.dart' as _i723;
import 'package:vstech_home_services/core/location/location_service.dart'
    as _i69;
import 'package:vstech_home_services/core/network/api_client.dart' as _i223;
import 'package:vstech_home_services/core/network/auth_token_store.dart'
    as _i381;
import 'package:vstech_home_services/core/session/session_cubit.dart' as _i371;
import 'package:vstech_home_services/core/storage/secure_auth_token_store.dart'
    as _i602;
import 'package:vstech_home_services/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i116;
import 'package:vstech_home_services/features/auth/data/datasources/profile_remote_data_source.dart'
    as _i599;
import 'package:vstech_home_services/features/auth/data/repositories/auth_repository_impl.dart'
    as _i408;
import 'package:vstech_home_services/features/auth/data/repositories/profile_repository_impl.dart'
    as _i117;
import 'package:vstech_home_services/features/auth/data/repositories/secure_credentials_repository.dart'
    as _i1020;
import 'package:vstech_home_services/features/auth/domain/repositories/auth_repository.dart'
    as _i731;
import 'package:vstech_home_services/features/auth/domain/repositories/credentials_repository.dart'
    as _i483;
import 'package:vstech_home_services/features/auth/domain/repositories/profile_repository.dart'
    as _i1025;
import 'package:vstech_home_services/features/auth/domain/usecases/get_profile_use_case.dart'
    as _i294;
import 'package:vstech_home_services/features/auth/domain/usecases/login_use_case.dart'
    as _i873;
import 'package:vstech_home_services/features/auth/domain/usecases/logout_use_case.dart'
    as _i1024;
import 'package:vstech_home_services/features/auth/domain/usecases/register_use_case.dart'
    as _i1073;
import 'package:vstech_home_services/features/auth/domain/usecases/update_profile_use_case.dart'
    as _i661;
import 'package:vstech_home_services/features/auth/presentation/bloc/login_cubit.dart'
    as _i242;
import 'package:vstech_home_services/features/auth/presentation/bloc/logout_cubit.dart'
    as _i188;
import 'package:vstech_home_services/features/auth/presentation/bloc/profile_cubit.dart'
    as _i275;
import 'package:vstech_home_services/features/auth/presentation/bloc/register_cubit.dart'
    as _i516;
import 'package:vstech_home_services/features/auth/presentation/bloc/splash_cubit.dart'
    as _i857;
import 'package:vstech_home_services/features/booking/data/datasources/booking_remote_data_source.dart'
    as _i261;
import 'package:vstech_home_services/features/booking/data/repositories/booking_repository_impl.dart'
    as _i511;
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart'
    as _i362;
import 'package:vstech_home_services/features/booking/domain/usecases/change_booking_status_use_case.dart'
    as _i118;
import 'package:vstech_home_services/features/booking/domain/usecases/create_booking_use_case.dart'
    as _i112;
import 'package:vstech_home_services/features/booking/domain/usecases/estimate_price_use_case.dart'
    as _i54;
import 'package:vstech_home_services/features/booking/domain/usecases/get_booking_use_case.dart'
    as _i736;
import 'package:vstech_home_services/features/booking/domain/usecases/get_my_bookings_use_case.dart'
    as _i16;
import 'package:vstech_home_services/features/booking/domain/usecases/quote_decision_use_case.dart'
    as _i528;
import 'package:vstech_home_services/features/booking/domain/usecases/worker_booking_use_cases.dart'
    as _i1056;
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart'
    as _i541;
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart'
    as _i859;
import 'package:vstech_home_services/features/home/data/datasources/category_remote_data_source.dart'
    as _i754;
import 'package:vstech_home_services/features/home/data/repositories/category_repository_impl.dart'
    as _i870;
import 'package:vstech_home_services/features/home/domain/repositories/category_repository.dart'
    as _i887;
import 'package:vstech_home_services/features/home/domain/usecases/get_categories_use_case.dart'
    as _i894;
import 'package:vstech_home_services/features/home/domain/usecases/get_category_use_case.dart'
    as _i653;
import 'package:vstech_home_services/features/home/presentation/bloc/categories_cubit.dart'
    as _i728;
import 'package:vstech_home_services/features/home/presentation/bloc/category_detail_cubit.dart'
    as _i983;
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart'
    as _i428;
import 'package:vstech_home_services/features/orders/presentation/bloc/order_detail_cubit.dart'
    as _i23;
import 'package:vstech_home_services/features/tracking/data/datasources/technician_location_remote_data_source.dart'
    as _i308;
import 'package:vstech_home_services/features/tracking/data/repositories/technician_location_repository_impl.dart'
    as _i61;
import 'package:vstech_home_services/features/tracking/domain/repositories/technician_location_repository.dart'
    as _i435;
import 'package:vstech_home_services/features/tracking/domain/usecases/update_technician_location_use_case.dart'
    as _i434;
import 'package:vstech_home_services/features/wallet/data/datasources/wallet_remote_data_source.dart'
    as _i964;
import 'package:vstech_home_services/features/wallet/data/repositories/wallet_repository_impl.dart'
    as _i794;
import 'package:vstech_home_services/features/wallet/domain/repositories/wallet_repository.dart'
    as _i637;
import 'package:vstech_home_services/features/wallet/domain/usecases/wallet_use_cases.dart'
    as _i1023;
import 'package:vstech_home_services/features/wallet/presentation/bloc/transaction_detail_cubit.dart'
    as _i664;
import 'package:vstech_home_services/features/wallet/presentation/bloc/wallet_cubit.dart'
    as _i64;
import 'package:vstech_home_services/features/worker_dashboard/presentation/bloc/worker_presence_cubit.dart'
    as _i686;
import 'package:vstech_home_services/features/worker_task/presentation/bloc/worker_task_cubit.dart'
    as _i101;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i69.LocationService>(
      () => const _i69.GeolocatorLocationService(),
    );
    gh.lazySingleton<_i483.CredentialsRepository>(
      () =>
          _i1020.SecureCredentialsRepository(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i381.AuthTokenStore>(
      () => _i602.SecureAuthTokenStore(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i371.SessionCubit>(
      () => _i371.SessionCubit(gh<_i381.AuthTokenStore>()),
    );
    gh.lazySingleton<_i223.ApiClient>(
      () => registerModule.apiClient(
        gh<_i381.AuthTokenStore>(),
        gh<_i371.SessionCubit>(),
      ),
    );
    gh.factory<_i116.AuthRemoteDataSource>(
      () => _i116.AuthRemoteDataSource(gh<_i223.ApiClient>()),
    );
    gh.factory<_i599.ProfileRemoteDataSource>(
      () => _i599.ProfileRemoteDataSource(gh<_i223.ApiClient>()),
    );
    gh.factory<_i261.BookingRemoteDataSource>(
      () => _i261.BookingRemoteDataSource(gh<_i223.ApiClient>()),
    );
    gh.factory<_i754.CategoryRemoteDataSource>(
      () => _i754.CategoryRemoteDataSource(gh<_i223.ApiClient>()),
    );
    gh.factory<_i308.TechnicianLocationRemoteDataSource>(
      () => _i308.TechnicianLocationRemoteDataSource(gh<_i223.ApiClient>()),
    );
    gh.factory<_i964.WalletRemoteDataSource>(
      () => _i964.WalletRemoteDataSource(gh<_i223.ApiClient>()),
    );
    gh.lazySingleton<_i731.AuthRepository>(
      () => _i408.AuthRepositoryImpl(
        gh<_i116.AuthRemoteDataSource>(),
        gh<_i381.AuthTokenStore>(),
      ),
    );
    gh.lazySingleton<_i887.CategoryRepository>(
      () => _i870.CategoryRepositoryImpl(gh<_i754.CategoryRemoteDataSource>()),
    );
    gh.factory<_i873.LoginUseCase>(
      () => _i873.LoginUseCase(gh<_i731.AuthRepository>()),
    );
    gh.factory<_i1024.LogoutUseCase>(
      () => _i1024.LogoutUseCase(gh<_i731.AuthRepository>()),
    );
    gh.factory<_i1073.RegisterUseCase>(
      () => _i1073.RegisterUseCase(gh<_i731.AuthRepository>()),
    );
    gh.lazySingleton<_i435.TechnicianLocationRepository>(
      () => _i61.TechnicianLocationRepositoryImpl(
        gh<_i308.TechnicianLocationRemoteDataSource>(),
      ),
    );
    gh.factory<_i516.RegisterCubit>(
      () => _i516.RegisterCubit(
        gh<_i1073.RegisterUseCase>(),
        gh<_i371.SessionCubit>(),
        gh<_i483.CredentialsRepository>(),
      ),
    );
    gh.lazySingleton<_i362.BookingRepository>(
      () => _i511.BookingRepositoryImpl(gh<_i261.BookingRemoteDataSource>()),
    );
    gh.factory<_i242.LoginCubit>(
      () => _i242.LoginCubit(
        gh<_i873.LoginUseCase>(),
        gh<_i371.SessionCubit>(),
        gh<_i483.CredentialsRepository>(),
      ),
    );
    gh.factory<_i118.CancelBookingUseCase>(
      () => _i118.CancelBookingUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i118.DisputeBookingUseCase>(
      () => _i118.DisputeBookingUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i112.CreateBookingUseCase>(
      () => _i112.CreateBookingUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i54.EstimatePriceUseCase>(
      () => _i54.EstimatePriceUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i736.GetBookingUseCase>(
      () => _i736.GetBookingUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i16.GetMyBookingsUseCase>(
      () => _i16.GetMyBookingsUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i528.ApproveQuoteUseCase>(
      () => _i528.ApproveQuoteUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i528.RejectQuoteUseCase>(
      () => _i528.RejectQuoteUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i1056.AcceptBookingUseCase>(
      () => _i1056.AcceptBookingUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i1056.StartBookingUseCase>(
      () => _i1056.StartBookingUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i1056.CompleteBookingUseCase>(
      () => _i1056.CompleteBookingUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i1056.SubmitQuoteUseCase>(
      () => _i1056.SubmitQuoteUseCase(gh<_i362.BookingRepository>()),
    );
    gh.factory<_i859.BookingActionCubit>(
      () => _i859.BookingActionCubit(
        gh<_i118.CancelBookingUseCase>(),
        gh<_i118.DisputeBookingUseCase>(),
      ),
    );
    gh.factory<_i188.LogoutCubit>(
      () => _i188.LogoutCubit(
        gh<_i1024.LogoutUseCase>(),
        gh<_i371.SessionCubit>(),
      ),
    );
    gh.lazySingleton<_i637.WalletRepository>(
      () => _i794.WalletRepositoryImpl(gh<_i964.WalletRemoteDataSource>()),
    );
    gh.lazySingleton<_i1025.ProfileRepository>(
      () => _i117.ProfileRepositoryImpl(gh<_i599.ProfileRemoteDataSource>()),
    );
    gh.factory<_i894.GetCategoriesUseCase>(
      () => _i894.GetCategoriesUseCase(gh<_i887.CategoryRepository>()),
    );
    gh.factory<_i653.GetCategoryUseCase>(
      () => _i653.GetCategoryUseCase(gh<_i887.CategoryRepository>()),
    );
    gh.factory<_i23.OrderDetailCubit>(
      () => _i23.OrderDetailCubit(
        gh<_i736.GetBookingUseCase>(),
        gh<_i653.GetCategoryUseCase>(),
      ),
    );
    gh.factory<_i101.WorkerTaskCubit>(
      () => _i101.WorkerTaskCubit(
        gh<_i736.GetBookingUseCase>(),
        gh<_i653.GetCategoryUseCase>(),
        gh<_i1056.AcceptBookingUseCase>(),
        gh<_i1056.StartBookingUseCase>(),
        gh<_i1056.SubmitQuoteUseCase>(),
        gh<_i1056.CompleteBookingUseCase>(),
      ),
    );
    gh.factory<_i428.BookingListCubit>(
      () => _i428.BookingListCubit(
        gh<_i16.GetMyBookingsUseCase>(),
        gh<_i894.GetCategoriesUseCase>(),
      ),
    );
    gh.factory<_i983.CategoryDetailCubit>(
      () => _i983.CategoryDetailCubit(gh<_i653.GetCategoryUseCase>()),
    );
    gh.factory<_i434.UpdateTechnicianLocationUseCase>(
      () => _i434.UpdateTechnicianLocationUseCase(
        gh<_i435.TechnicianLocationRepository>(),
      ),
    );
    gh.factory<_i1023.GetWalletUseCase>(
      () => _i1023.GetWalletUseCase(gh<_i637.WalletRepository>()),
    );
    gh.factory<_i1023.GetTransactionsUseCase>(
      () => _i1023.GetTransactionsUseCase(gh<_i637.WalletRepository>()),
    );
    gh.factory<_i1023.CreateWithdrawalUseCase>(
      () => _i1023.CreateWithdrawalUseCase(gh<_i637.WalletRepository>()),
    );
    gh.factory<_i1023.GetWithdrawalUseCase>(
      () => _i1023.GetWithdrawalUseCase(gh<_i637.WalletRepository>()),
    );
    gh.factory<_i1023.GetTransactionUseCase>(
      () => _i1023.GetTransactionUseCase(gh<_i637.WalletRepository>()),
    );
    gh.factory<_i294.GetProfileUseCase>(
      () => _i294.GetProfileUseCase(gh<_i1025.ProfileRepository>()),
    );
    gh.factory<_i661.UpdateProfileUseCase>(
      () => _i661.UpdateProfileUseCase(gh<_i1025.ProfileRepository>()),
    );
    gh.factory<_i275.ProfileCubit>(
      () => _i275.ProfileCubit(
        gh<_i294.GetProfileUseCase>(),
        gh<_i661.UpdateProfileUseCase>(),
      ),
    );
    gh.factory<_i728.CategoriesCubit>(
      () => _i728.CategoriesCubit(gh<_i894.GetCategoriesUseCase>()),
    );
    gh.factory<_i664.TransactionDetailCubit>(
      () => _i664.TransactionDetailCubit(gh<_i1023.GetTransactionUseCase>()),
    );
    gh.factory<_i541.BookingFlowBloc>(
      () => _i541.BookingFlowBloc(
        gh<_i653.GetCategoryUseCase>(),
        gh<_i294.GetProfileUseCase>(),
        gh<_i54.EstimatePriceUseCase>(),
        gh<_i112.CreateBookingUseCase>(),
        gh<_i69.LocationService>(),
      ),
    );
    gh.lazySingleton<_i686.WorkerPresenceCubit>(
      () => _i686.WorkerPresenceCubit(
        gh<_i69.LocationService>(),
        gh<_i434.UpdateTechnicianLocationUseCase>(),
        gh<_i371.SessionCubit>(),
      ),
    );
    gh.factory<_i857.SplashCubit>(
      () => _i857.SplashCubit(
        gh<_i371.SessionCubit>(),
        gh<_i294.GetProfileUseCase>(),
      ),
    );
    gh.factory<_i64.WalletCubit>(
      () => _i64.WalletCubit(
        gh<_i1023.GetWalletUseCase>(),
        gh<_i1023.GetTransactionsUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i723.RegisterModule {}
