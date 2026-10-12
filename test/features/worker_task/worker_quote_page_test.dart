import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/quote_form_cubit.dart';
import 'package:vstech_home_services/features/worker_task/presentation/pages/worker_quote_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../helpers/mocks.dart';

const _empty = QuoteFormEditingState(
  bookingId: '502',
  serviceName: 'Vệ sinh máy lạnh',
  estimatedPrice: 400000,
  lines: [QuoteDraftLine(id: 0)],
);

Widget _app(MockQuoteFormCubit cubit, {List<String>? popped}) {
  final router = GoRouter(
    initialLocation: '/start',
    routes: [
      GoRoute(
        path: '/start',
        builder: (context, state) => Scaffold(
          body: TextButton(
            onPressed: () async {
              final result = await context.push<bool>('/quote');
              popped?.add('$result');
            },
            child: const Text('OpenQuote'),
          ),
        ),
      ),
      GoRoute(
        path: '/quote',
        builder: (context, state) => BlocProvider<QuoteFormCubit>.value(
          value: cubit,
          child: const WorkerQuotePage(bookingId: '502'),
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

MockQuoteFormCubit _cubit(
  QuoteFormState state, {
  Stream<QuoteFormState> stream = const Stream.empty(),
}) {
  final cubit = MockQuoteFormCubit();
  when(cubit.submit).thenAnswer((_) async {});
  whenListen(cubit, stream, initialState: state);
  return cubit;
}

Future<void> _open(
  WidgetTester tester,
  MockQuoteFormCubit cubit, {
  List<String>? popped,
}) async {
  await tester.binding.setSurfaceSize(const Size(420, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(_app(cubit, popped: popped));
  await tester.tap(find.text('OpenQuote'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'empty form: header, estimate with the cap note, send disabled, no remove button',
    (tester) async {
      await _open(tester, _cubit(_empty));

      expect(find.text('Báo giá phát sinh'), findsOneWidget);
      expect(find.text('Đơn #502 · Vệ sinh máy lạnh'), findsOneWidget);
      expect(find.text('400.000đ'), findsOneWidget);
      expect(
        find.text('Tổng tiền đơn không được vượt 1,5 lần giá ước tính'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('quote_line_remove_0')), findsNothing);
      final send = tester.widget<ElevatedButton>(
        find.descendant(
          of: find.byKey(const Key('quote_submit')),
          matching: find.byType(ElevatedButton),
        ),
      );
      expect(send.onPressed, isNull);
    },
  );

  testWidgets('typing forwards to the cubit; add / remove line; send', (
    tester,
  ) async {
    const twoLines = QuoteFormEditingState(
      bookingId: '502',
      estimatedPrice: 400000,
      lines: [
        QuoteDraftLine(id: 0, name: 'Ron cao su', amount: 30000),
        QuoteDraftLine(id: 1, name: 'Công thay ron', amount: 15000),
      ],
    );
    final cubit = _cubit(twoLines);

    await _open(tester, cubit);
    expect(find.text('45.000đ'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('quote_line_name_0')), 'Ron');
    verify(() => cubit.updateName(0, 'Ron')).called(1);
    await tester.enterText(
      find.byKey(const Key('quote_line_amount_1')),
      '20000',
    );
    verify(() => cubit.updateAmount(1, '20000')).called(1);

    await tester.tap(find.byKey(const Key('quote_line_remove_1')));
    verify(() => cubit.removeLine(1)).called(1);
    await tester.tap(find.byKey(const Key('quote_add_line')));
    verify(cubit.addLine).called(1);
    await tester.tap(find.byKey(const Key('quote_submit')));
    verify(cubit.submit).called(1);
  });

  testWidgets(
    'validation errors and the 1.5× cap banner show with icon + text',
    (tester) async {
      const invalid = QuoteFormEditingState(
        bookingId: '502',
        estimatedPrice: 400000,
        showErrors: true,
        lines: [
          QuoteDraftLine(id: 0, amount: 0),
          QuoteDraftLine(id: 1, name: 'Thay block', amount: 220000),
        ],
      );

      await _open(tester, _cubit(invalid));

      expect(find.text('Nhập tên hạng mục'), findsOneWidget);
      expect(find.text('Nhập số tiền lớn hơn 0đ'), findsOneWidget);
      expect(find.byKey(const Key('quote_cap_error')), findsOneWidget);
      expect(find.textContaining('620.000đ'), findsOneWidget);
    },
  );

  testWidgets('closes with true once the quote is sent', (tester) async {
    final popped = <String>[];
    final cubit = _cubit(
      _empty,
      stream: Stream.value(
        const QuoteFormEditingState(
          bookingId: '502',
          lines: [QuoteDraftLine(id: 0, name: 'Gas', amount: 45000)],
          submitted: SubmittedQuote(
            bookingId: '502',
            status: QuoteStatus.pending,
            lines: [QuoteLine(itemName: 'Gas', amount: 45000)],
            totalAmount: 45000,
          ),
        ),
      ),
    );

    await _open(tester, cubit, popped: popped);

    expect(find.text('OpenQuote'), findsOneWidget);
    expect(popped, ['true']);
  });
}
