import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/domain/entities/remembered_credentials.dart';

/// "Remember me" storage, kept per role because the login screen switches between the customer
/// and worker forms. Survives logout on purpose.
abstract interface class CredentialsRepository {
  Future<RememberedCredentials?> read(UserRole role);

  Future<void> save(UserRole role, RememberedCredentials credentials);

  Future<void> clear(UserRole role);
}
