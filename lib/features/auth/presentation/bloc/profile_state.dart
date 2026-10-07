part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {
  const ProfileState();

  /// The last known profile, available in every state after the first successful load.
  UserProfile? get profile => null;
}

final class ProfileInitialState extends ProfileState {
  const ProfileInitialState();
}

final class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

final class ProfileLoadErrorState extends ProfileState {
  const ProfileLoadErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is ProfileLoadErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}

/// Base for every state that already has a profile to show.
sealed class ProfileWithDataState extends ProfileState {
  const ProfileWithDataState(this.data);

  final UserProfile data;

  @override
  UserProfile get profile => data;

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType && other is ProfileWithDataState && other.data == data;

  @override
  int get hashCode => Object.hash(runtimeType, data);
}

final class ProfileLoadedState extends ProfileWithDataState {
  const ProfileLoadedState(super.data);
}

final class ProfileSavingState extends ProfileWithDataState {
  const ProfileSavingState(super.data);
}

/// Saved successfully — pages show a confirmation and usually pop.
final class ProfileSavedState extends ProfileWithDataState {
  const ProfileSavedState(super.data);
}

final class ProfileSaveErrorState extends ProfileWithDataState {
  const ProfileSaveErrorState(super.data, this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => super == other && other is ProfileSaveErrorState && other.failure == failure;

  @override
  int get hashCode => Object.hash(super.hashCode, failure);
}
