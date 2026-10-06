import 'dart:async';

import 'package:flutter/foundation.dart';

/// Adapts a BLoC/Cubit stream into the [Listenable] GoRouter's `refreshListenable` expects, so
/// `redirect` re-runs whenever the session changes.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<Object?> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
