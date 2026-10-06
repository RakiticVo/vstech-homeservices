import 'package:vstech_home_services/core/error/failure.dart';

/// Return type of every repository method: either [Ok] with a value or [Err] with a [Failure].
sealed class Result<T> {
  const Result();

  /// Runs [body], converting any thrown error into [Err].
  static Future<Result<T>> guard<T>(Future<T> Function() body) async {
    try {
      return Ok(await body());
    } on Object catch (e, st) {
      return Err(Failure.from(e, st));
    }
  }
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
