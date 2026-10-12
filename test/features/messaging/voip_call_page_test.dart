import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/voip_call_cubit.dart';
import 'package:vstech_home_services/features/messaging/presentation/pages/voip_call_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../helpers/mocks.dart';

const _call = VoipCall(id: '70', bookingId: '502');

Widget _app(MockVoipCallCubit cubit, {bool isWorker = false}) {
  final router = GoRouter(
    initialLocation: '/start',
    routes: [
      GoRoute(
        path: '/start',
        builder: (context, state) => Scaffold(
          body: TextButton(
            onPressed: () => context.push('/call'),
            child: const Text('OpenCall'),
          ),
        ),
      ),
      GoRoute(
        path: '/call',
        builder: (context, state) => BlocProvider<VoipCallCubit>.value(
          value: cubit,
          child: VoipCallPage(bookingId: '502', isWorker: isWorker),
        ),
      ),
    ],
  );
  return MaterialApp.router(
    theme: AppTheme.light,
    routerConfig: router,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('vi'),
  );
}

MockVoipCallCubit _cubit(
  VoipCallState state, {
  Stream<VoipCallState> stream = const Stream.empty(),
}) {
  final cubit = MockVoipCallCubit();
  when(cubit.hangUp).thenAnswer((_) async {});
  whenListen(cubit, stream, initialState: state);
  return cubit;
}

Future<void> _open(
  WidgetTester tester,
  MockVoipCallCubit cubit, {
  bool isWorker = false,
}) async {
  await tester.binding.setSurfaceSize(const Size(400, 860));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(_app(cubit, isWorker: isWorker));
  await tester.tap(find.text('OpenCall'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'active call shows the peer role, order, talk time, the preview notice and controls',
    (tester) async {
      final cubit = _cubit(
        const VoipCallActiveState(
          call: _call,
          elapsedSeconds: 48,
          isMuted: true,
        ),
      );

      await _open(tester, cubit);

      expect(find.text('Thợ phụ trách'), findsOneWidget);
      expect(find.text('Đơn #502'), findsOneWidget);
      expect(find.text('00:48'), findsOneWidget);
      expect(
        find.textContaining('âm thanh cuộc gọi chưa được kết nối'),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key('call_mute_button')));
      verify(cubit.toggleMute).called(1);
      await tester.tap(find.byKey(const Key('call_end_button')));
      verify(cubit.hangUp).called(1);
    },
  );

  testWidgets('starting shows Connecting; worker sees the customer role', (
    tester,
  ) async {
    await _open(tester, _cubit(const VoipCallStartingState()), isWorker: true);

    expect(find.text('Khách hàng'), findsOneWidget);
    expect(find.text('Đang kết nối…'), findsOneWidget);
  });

  testWidgets('a start error explains why and offers Close', (tester) async {
    await _open(
      tester,
      _cubit(
        const VoipCallErrorState(Failure(kind: NetworkErrorKind.noConnection)),
      ),
    );

    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    await tester.tap(find.byKey(const Key('call_close_button')));
    await tester.pumpAndSettle();
    expect(find.text('OpenCall'), findsOneWidget);
  });

  testWidgets('the screen closes once the call has ended', (tester) async {
    final cubit = _cubit(
      const VoipCallActiveState(call: _call),
      stream: Stream.value(const VoipCallEndedState(durationSeconds: 3)),
    );

    await _open(tester, cubit);

    expect(find.text('OpenCall'), findsOneWidget);
  });
}
