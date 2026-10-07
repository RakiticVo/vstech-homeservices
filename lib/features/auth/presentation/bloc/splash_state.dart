part of 'splash_cubit.dart';

enum SplashDestination { onboarding, customerHome, workerHome }

@immutable
sealed class SplashState {
  const SplashState();
}

final class SplashInitialState extends SplashState {
  const SplashInitialState();
}

final class SplashLoadingState extends SplashState {
  const SplashLoadingState();
}

final class SplashResolvedState extends SplashState {
  const SplashResolvedState(this.destination);

  final SplashDestination destination;

  @override
  bool operator ==(Object other) => other is SplashResolvedState && other.destination == destination;

  @override
  int get hashCode => destination.hashCode;
}

/// Profile could not be loaded for a reason other than an expired session (offline, 5xx).
final class SplashErrorState extends SplashState {
  const SplashErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is SplashErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
