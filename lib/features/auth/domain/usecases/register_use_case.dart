import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/domain/entities/app_user.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/auth_repository.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/phone_normalizer.dart';

@injectable
class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AppUser>> call({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) => _repository.register(
    fullName: fullName.trim(),
    email: email.trim(),
    phone: normalizePhone(phone),
    password: password,
    role: role,
  );
}
