import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/quote_form_cubit.dart';

import '../../../fixtures/booking/booking_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);
const _sent = SubmittedQuote(
  bookingId: '501',
  status: QuoteStatus.pending,
  lines: [QuoteLine(itemName: 'Gas', amount: 45000)],
  totalAmount: 45000,
);

void main() {
  late MockGetBookingUseCase getBooking;
  late MockGetCategoryUseCase getCategory;
  late MockSubmitQuoteUseCase submitQuote;

  setUpAll(() => registerFallbackValue(<QuoteLine>[]));

  setUp(() {
    getBooking = MockGetBookingUseCase();
    getCategory = MockGetCategoryUseCase();
    submitQuote = MockSubmitQuoteUseCase();
    when(() => getBooking('501'))
        .thenAnswer((_) async => Ok<Booking>(pendingBooking));
    when(() => getCategory('1'))
        .thenAnswer((_) async => const Ok<ServiceCategory>(acCategory));
  });

  QuoteFormCubit build() =>
      QuoteFormCubit(getBooking, getCategory, submitQuote);

  /// Loads the form; the first draft line gets id 0.
  Future<QuoteFormCubit> loaded() async {
    final cubit = build();
    await cubit.load('501');
    return cubit;
  }

  QuoteFormEditingState editing(QuoteFormCubit cubit) =>
      cubit.state as QuoteFormEditingState;

  blocTest<QuoteFormCubit, QuoteFormState>(
    'load starts with one empty line, the estimate and the service name',
    build: build,
    act: (cubit) => cubit.load('501'),
    expect: () => [
      const QuoteFormLoadingState(),
      const QuoteFormEditingState(
        bookingId: '501',
        serviceName: 'Sửa máy lạnh',
        estimatedPrice: 500000,
        lines: [QuoteDraftLine(id: 0)],
      ),
    ],
  );

  blocTest<QuoteFormCubit, QuoteFormState>(
    'load failure is emitted',
    setUp: () =>
        when(() => getBooking('501'))
            .thenAnswer((_) async => const Err<Booking>(_offline)),
    build: build,
    act: (cubit) => cubit.load('501'),
    expect: () => [
      const QuoteFormLoadingState(),
      const QuoteFormLoadErrorState(_offline),
    ],
  );

  test('editing lines updates the total; the last line cannot be removed; max 10 lines', () async {
    final cubit = await loaded();

    cubit
      ..updateName(0, 'Ron cao su')
      ..updateAmount(0, '30.000')
      ..addLine()
      ..updateName(1, 'Công thay ron')
      ..updateAmount(1, '15000');
    expect(editing(cubit).total, 45000);
    expect(editing(cubit).hasInput, isTrue);

    cubit.removeLine(1);
    expect(editing(cubit).lines.map((l) => l.id), [0]);
    cubit.removeLine(0);
    expect(editing(cubit).lines, hasLength(1));

    for (var i = 0; i < 12; i++) {
      cubit.addLine();
    }
    expect(editing(cubit).lines, hasLength(10));
    expect(editing(cubit).canAddLine, isFalse);
    await cubit.close();
  });

  test('submit with an invalid line only reveals the errors', () async {
    final cubit = await loaded();
    cubit.updateName(0, 'Gas');

    await cubit.submit();

    expect(editing(cubit).showErrors, isTrue);
    expect(editing(cubit).isValid, isFalse);
    verifyNever(
      () => submitQuote(
        any(),
        any(),
        estimatedPrice: any(named: 'estimatedPrice'),
      ),
    );
    await cubit.close();
  });

  test('a total above 1.5× the estimate blocks sending', () async {
    final cubit = await loaded();
    cubit
      ..updateName(0, 'Thay block')
      ..updateAmount(0, '260000');

    expect(editing(cubit).exceedsCap, isTrue);
    expect(editing(cubit).cap, 750000);
    await cubit.submit();
    verifyNever(
      () => submitQuote(
        any(),
        any(),
        estimatedPrice: any(named: 'estimatedPrice'),
      ),
    );
    await cubit.close();
  });

  test(
    'a valid quote is sent with the estimate and marks the form submitted',
    () async {
      when(() => submitQuote('501', any(), estimatedPrice: 500000))
          .thenAnswer((_) async => const Ok(_sent));
      final cubit = await loaded();
      cubit
        ..updateName(0, 'Gas')
        ..updateAmount(0, '45000');

      await cubit.submit();

      expect(editing(cubit).submitted, _sent);
      final lines =
          verify(() => submitQuote('501', captureAny(), estimatedPrice: 500000))
                  .captured
                  .single
              as List<QuoteLine>;
      expect(lines, const [QuoteLine(itemName: 'Gas', amount: 45000)]);
      await cubit.close();
    },
  );

  test('a send failure keeps the form and reports it once', () async {
    when(
      () => submitQuote(
        '501',
        any(),
        estimatedPrice: any(named: 'estimatedPrice'),
      ),
    ).thenAnswer((_) async => const Err(_offline));
    final cubit = await loaded();
    cubit
      ..updateName(0, 'Gas')
      ..updateAmount(0, '45000');

    await cubit.submit();

    expect(editing(cubit).failure, _offline);
    expect(editing(cubit).isSending, isFalse);
    cubit.updateName(0, 'Gas R32');
    expect(editing(cubit).failure, isNull);
    await cubit.close();
  });
}
