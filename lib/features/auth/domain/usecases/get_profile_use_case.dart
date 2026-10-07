import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/profile_repository.dart';

@injectable
class GetProfileUseCase {
  const GetProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<UserProfile>> call() => _repository.getProfile();
}
