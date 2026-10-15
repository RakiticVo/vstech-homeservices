import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/categories_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/category_detail_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/pages/categories_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/customer_home_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/service_detail_page.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/customer_floating_dock.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/home_devices_card.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/home_top_header.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/service_category_tile.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/booking/booking_fixtures.dart';
import '../../helpers/mocks.dart';

final List<ServiceCategory> _tenCategories = [
  for (var i = 1; i <= 10; i++)
    ServiceCategory(id: '$i', name: 'Dịch vụ $i', basePrice: 100000 * i),
];

Widget _createTestHomeWidget(
  Widget child, {
  required MockCategoriesCubit categories,
  MockCategoryDetailCubit? detail,
}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.serviceDetail,
        builder: (context, state) => Scaffold(
          body: Text('ServiceDetail:${state.uri.queryParameters['id']}'),
        ),
      ),
      GoRoute(
        path: AppRoutes.bookingStep1,
        builder: (context, state) => Scaffold(
          body: Text('BookingStep1:${state.uri.queryParameters['categoryId']}'),
        ),
      ),
    ],
  );

  return MultiBlocProvider(
    providers: [
      BlocProvider<CategoriesCubit>.value(value: categories),
      BlocProvider<CategoryDetailCubit>.value(
        value: detail ?? MockCategoryDetailCubit(),
      ),
    ],
    child: MaterialApp.router(
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
    ),
  );
}

void main() {
  late MockCategoriesCubit categories;

  setUp(() {
    categories = MockCategoriesCubit();
    when(() => categories.load()).thenAnswer((_) async {});
  });

  group('Customer Home & Categories (GET /service-categories)', () {
    testWidgets(
      'CustomerHomePage shows at most 8 categories from the API, devices card and dock',
      (tester) async {
        whenListen(
          categories,
          const Stream<CategoriesState>.empty(),
          initialState: CategoriesLoadedState(_tenCategories),
        );

        await tester.pumpWidget(
          _createTestHomeWidget(
            const CustomerHomePage(),
            categories: categories,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(HomeTopHeader), findsOneWidget);
        expect(find.byType(ServiceCategoryTile), findsNWidgets(8));
        expect(find.text('Dịch vụ 1'), findsOneWidget);
        expect(find.text('Dịch vụ 9'), findsNothing);
        // Promotions have no API, so the offers section is gone.
        expect(find.text('Ưu đãi đặc quyền'), findsNothing);
        expect(find.byType(HomeDevicesCard), findsOneWidget);
        expect(find.byType(CustomerFloatingDock), findsOneWidget);

        await tester.tap(find.text('Dịch vụ 3'));
        await tester.pumpAndSettle();
        expect(find.text('ServiceDetail:3'), findsOneWidget);
      },
    );

    testWidgets(
      'CustomerHomePage shows a retry view when categories fail to load',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(800, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        whenListen(
          categories,
          const Stream<CategoriesState>.empty(),
          initialState: const CategoriesErrorState(
            Failure(kind: NetworkErrorKind.noConnection),
          ),
        );

        await tester.pumpWidget(
          _createTestHomeWidget(
            const CustomerHomePage(),
            categories: categories,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('Không có kết nối mạng'), findsOneWidget);
        await tester.tap(find.byKey(const Key('error_retry_button')));
        verify(() => categories.load()).called(1);
      },
    );

    testWidgets('CustomerHomePage dock tab selection updates active tab', (
      tester,
    ) async {
      whenListen(
        categories,
        const Stream<CategoriesState>.empty(),
        initialState: const CategoriesLoadingState(),
      );

      await tester.pumpWidget(
        _createTestHomeWidget(const CustomerHomePage(), categories: categories),
      );
      await tester.pump();

      await tester.tap(find.byIcon(Icons.receipt_long_outlined));
      await tester.pump();

      expect(find.text('Đơn hàng'), findsOneWidget);
    });

    testWidgets(
      'CategoriesPage lists API categories with starting price and filters by search',
      (tester) async {
        whenListen(
          categories,
          const Stream<CategoriesState>.empty(),
          initialState: const CategoriesLoadedState([
            acCategory,
            cleanCategory,
          ]),
        );

        await tester.pumpWidget(
          _createTestHomeWidget(const CategoriesPage(), categories: categories),
        );
        await tester.pumpAndSettle();

        expect(find.text('Sửa máy lạnh'), findsOneWidget);
        expect(find.text('Từ 200.000đ'), findsOneWidget);
        expect(find.text('Vệ sinh nhà'), findsOneWidget);

        await tester.enterText(
          find.byKey(const Key('categories_search_field')),
          'máy lạnh',
        );
        await tester.pumpAndSettle();
        expect(find.text('Vệ sinh nhà'), findsNothing);

        await tester.enterText(
          find.byKey(const Key('categories_search_field')),
          'không có',
        );
        await tester.pumpAndSettle();
        expect(find.text('Không tìm thấy dịch vụ phù hợp.'), findsOneWidget);
      },
    );

    testWidgets(
      'ServiceDetailPage loads the category and starts booking with its id',
      (tester) async {
        final detail = MockCategoryDetailCubit();
        when(() => detail.load(any())).thenAnswer((_) async {});
        whenListen(
          detail,
          const Stream<CategoryDetailState>.empty(),
          initialState: const CategoryDetailLoadedState(acCategory),
        );

        await tester.pumpWidget(
          _createTestHomeWidget(
            const ServiceDetailPage(serviceId: '1'),
            categories: categories,
            detail: detail,
          ),
        );
        await tester.pumpAndSettle();

        verify(() => detail.load('1')).called(1);
        expect(find.text('Sửa máy lạnh'), findsWidgets);
        expect(find.text('Sửa chữa máy lạnh các loại'), findsOneWidget);
        expect(find.text('Từ 200.000đ'), findsOneWidget);
        expect(find.text('Bảo hành 0đ trong 30 ngày'), findsOneWidget);

        await tester.tap(find.byKey(const Key('service_detail_book_button')));
        await tester.pumpAndSettle();
        expect(find.text('BookingStep1:1'), findsOneWidget);
      },
    );
  });
}
