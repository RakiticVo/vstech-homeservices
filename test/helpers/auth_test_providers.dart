import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/login_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/logout_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/profile_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/register_cubit.dart';

import 'mocks.dart';

/// Mock auth cubits for widget tests of pages that are normally provided by their GoRoute.
/// Wrap the test app with [wrap] so every route inside it can read them.
class AuthTestProviders {
  AuthTestProviders({UserProfile? profile}) {
    registerFallbackValue(const ProfileUpdate());
    registerFallbackValue(UserRole.customer);
    whenListen(login, loginStates.stream, initialState: const AuthFormInitialState());
    when(() => login.prefill(any())).thenAnswer((_) async {});
    whenListen(register, registerStates.stream, initialState: const AuthFormInitialState());
    whenListen(logout, _logoutStates.stream, initialState: const LogoutInitialState());
    when(logout.logout).thenAnswer((_) async => _logoutStates.add(const LogoutDoneState()));
    whenListen<ProfileState>(
      this.profile,
      _profileStates.stream,
      initialState: profile == null ? const ProfileLoadingState() : ProfileLoadedState(profile),
    );
    when(() => this.profile.load()).thenAnswer((_) async {});
    when(() => this.profile.save(any())).thenAnswer((_) async {
      if (profile != null) _profileStates.add(ProfileSavedState(profile));
    });
  }

  final login = MockLoginCubit();
  final register = MockRegisterCubit();
  final logout = MockLogoutCubit();
  final profile = MockProfileCubit();

  /// Push states here to drive the login/register pages' listeners.
  final loginStates = StreamController<AuthFormState>.broadcast();
  final registerStates = StreamController<AuthFormState>.broadcast();

  final _logoutStates = StreamController<LogoutState>.broadcast();
  final _profileStates = StreamController<ProfileState>.broadcast();

  Widget wrap(Widget app) => MultiBlocProvider(
    providers: [
      BlocProvider<LoginCubit>.value(value: login),
      BlocProvider<RegisterCubit>.value(value: register),
      BlocProvider<LogoutCubit>.value(value: logout),
      BlocProvider<ProfileCubit>.value(value: profile),
    ],
    child: app,
  );

  Future<void> dispose() async {
    await loginStates.close();
    await registerStates.close();
    await _logoutStates.close();
    await _profileStates.close();
  }
}
