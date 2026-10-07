import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/auth/domain/entities/app_user.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/auth_repository.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/phone_normalizer.dart';

@injectable
class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  /// [identifier] may be a phone number typed with spaces/dots ("0901 234 567") or an email.
  Future<Result<AppUser>> call({required String identifier, required String password}) => _repository.login(
    identifier: identifier.contains('@') ? identifier.trim() : normalizePhone(identifier),
    password: password,
  );
}
