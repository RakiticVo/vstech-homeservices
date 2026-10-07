import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/update_profile_use_case.dart';

part 'profile_state.dart';

/// Loads and edits the signed-in user's profile. Provided per route (profile, edit profile,
/// edit address, worker profile).
@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfile, this._updateProfile) : super(const ProfileInitialState());

  final GetProfileUseCase _getProfile;
  final UpdateProfileUseCase _updateProfile;

  Future<void> load() async {
    emit(const ProfileLoadingState());
    switch (await _getProfile()) {
      case Ok(:final value):
        emit(ProfileLoadedState(value));
      case Err(:final failure):
        emit(ProfileLoadErrorState(failure));
    }
  }

  Future<void> save(ProfileUpdate update) async {
    final current = state.profile;
    if (current == null || state is ProfileSavingState) return;
    emit(ProfileSavingState(current));
    switch (await _updateProfile(update)) {
      case Ok(:final value):
        emit(ProfileSavedState(value));
      case Err(:final failure):
        emit(ProfileSaveErrorState(current, failure));
    }
  }
}
