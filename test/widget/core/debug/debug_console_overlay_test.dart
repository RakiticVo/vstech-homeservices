import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vstech_home_services/core/debug/debug_console_overlay.dart';
import 'package:vstech_home_services/core/debug/debug_log_store.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _app(DebugLogStore store) => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  locale: const Locale('vi'),
  builder: (context, child) => DebugConsoleOverlay(store: store, child: child!),
  home: const Scaffold(body: Text('AppScreen')),
);

DebugLogStore _seeded() {
  final store = DebugLogStore()
    ..addLog(
      DebugLogEntry(
        time: DateTime(2026, 10, 15, 9),
        source: DebugLogSource.app,
        level: DebugLogLevel.info,
        message: 'App started',
      ),
    )
    ..addLog(
      DebugLogEntry(
        time: DateTime(2026, 10, 15, 9, 1),
        source: DebugLogSource.app,
        level: DebugLogLevel.error,
        message: 'Boom',
      ),
    );
  final ok = store.startCall(
    method: 'GET',
    url: 'https://api.test/api/v1/service-categories',
  );
  store.finishCall(
    ok,
    statusCode: 200,
    durationMs: 80,
    responseBody: '{"data":[]}',
  );
  final bad = store.startCall(
    method: 'POST',
    url: 'https://api.test/api/v1/auth/login',
    requestBody: '{"password":"***"}',
  );
  store.finishCall(
    bad,
    statusCode: 502,
    durationMs: 2000,
    responseBody: '<html>Bad Gateway</html>',
  );
  return store;
}

void main() {
  testWidgets(
    'the debug button shows failures and opens the console over the app',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(420, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_app(_seeded()));
      await tester.pumpAndSettle();

      expect(find.text('AppScreen'), findsOneWidget);
      expect(find.text('Debug · 1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('debug_console_button')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('debug_console_panel')), findsOneWidget);
      expect(find.text('POST /api/v1/auth/login'), findsOneWidget);
      expect(find.text('502'), findsOneWidget);

      // Detail with request / response.
      await tester.tap(find.text('POST /api/v1/auth/login'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('debug_call_detail')), findsOneWidget);
      expect(find.text('{"password":"***"}'), findsOneWidget);
      expect(find.text('<html>Bad Gateway</html>'), findsOneWidget);

      await tester.tap(find.byKey(const Key('debug_console_close')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('debug_console_panel')), findsNothing);
      expect(find.byKey(const Key('debug_console_button')), findsOneWidget);
    },
  );

  testWidgets('logs can be filtered to errors; clear empties the console', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final store = _seeded();

    await tester.pumpWidget(_app(store));
    await tester.tap(find.byKey(const Key('debug_console_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log'));
    await tester.pumpAndSettle();

    expect(find.text('App started'), findsOneWidget);
    await tester.tap(find.byKey(const Key('debug_log_filter_errors')));
    await tester.pumpAndSettle();
    expect(find.text('App started'), findsNothing);
    expect(find.text('Boom'), findsOneWidget);

    await tester.tap(find.byKey(const Key('debug_clear')));
    await tester.pumpAndSettle();
    expect(store.logs, isEmpty);
    expect(find.text('Chưa có dữ liệu'), findsOneWidget);
  });
}
