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
    return this;
  }
}

class _$RegisterModule extends _i723.RegisterModule {}
