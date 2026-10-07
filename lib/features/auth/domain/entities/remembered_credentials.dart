import 'package:freezed_annotation/freezed_annotation.dart';

part 'remembered_credentials.freezed.dart';

/// Phone/email + password the user chose to remember, shown again on the login screen after
/// logging out.
@freezed
abstract class RememberedCredentials with _$RememberedCredentials {
  const factory RememberedCredentials({required String identifier, required String password}) = _RememberedCredentials;
}
