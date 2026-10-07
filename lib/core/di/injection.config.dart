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
import 'package:vstech_home_services/features/auth/domain/repositories/auth_repository.dart'
    as _i731;
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
    gh.lazySingleton<_i731.AuthRepository>(
      () => _i408.AuthRepositoryImpl(
        gh<_i116.AuthRemoteDataSource>(),
        gh<_i381.AuthTokenStore>(),
      ),
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
    gh.factory<_i516.RegisterCubit>(
      () => _i516.RegisterCubit(
        gh<_i1073.RegisterUseCase>(),
        gh<_i371.SessionCubit>(),
      ),
    );
    gh.factory<_i188.LogoutCubit>(
      () => _i188.LogoutCubit(
        gh<_i1024.LogoutUseCase>(),
        gh<_i371.SessionCubit>(),
      ),
    );
    gh.lazySingleton<_i1025.ProfileRepository>(
      () => _i117.ProfileRepositoryImpl(gh<_i599.ProfileRemoteDataSource>()),
    );
    gh.factory<_i242.LoginCubit>(
      () =>
          _i242.LoginCubit(gh<_i873.LoginUseCase>(), gh<_i371.SessionCubit>()),
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
    gh.factory<_i857.SplashCubit>(
      () => _i857.SplashCubit(
        gh<_i371.SessionCubit>(),
        gh<_i294.GetProfileUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i723.RegisterModule {}
