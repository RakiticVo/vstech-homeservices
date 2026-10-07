import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/data/datasources/profile_remote_data_source.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_response.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_update_request.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remote);

  final ProfileRemoteDataSource _remote;

  @override
  Future<Result<UserProfile>> getProfile() => Result.guard(() async => _toEntity(await _remote.getProfile()));

  @override
  Future<Result<UserProfile>> updateProfile(ProfileUpdate update) => Result.guard(() async {
    final response = await _remote.updateProfile(
      UserProfileUpdateRequest(
        fullName: update.fullName,
        phoneNumber: update.phoneNumber,
        email: update.email,
        defaultAddress: update.defaultAddress,
        lat: update.lat,
        lng: update.lng,
      ),
    );
    return _toEntity(response);
  });

  static UserProfile _toEntity(UserProfileResponse r) => UserProfile(
    id: r.id,
    role: UserRole.fromApi(r.role),
    fullName: r.fullName ?? '',
    email: r.email,
    phoneNumber: r.phoneNumber,
    avatarUrl: r.avatarUrl,
    bio: r.bio,
    locale: r.locale,
    defaultAddress: r.userProfile?.defaultAddress,
    lat: r.userProfile?.lat,
    lng: r.userProfile?.lng,
    rating: r.workerMetrics?.averageRating ?? r.rating,
    totalJobs: r.totalJobs,
    verificationStatus: r.verificationStatus,
    kycApprovalStatus: r.workerKyc?.approvalStatus,
    completedJobs: r.workerMetrics?.totalCompletedJobs,
    cancellationRate: r.workerMetrics?.cancellationRate,
    badgeTier: r.workerMetrics?.badgeTier,
  );
}
