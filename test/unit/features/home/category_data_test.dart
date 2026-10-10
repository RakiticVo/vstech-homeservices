import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/home/data/datasources/category_remote_data_source.dart';
import 'package:vstech_home_services/features/home/data/models/service_category_response.dart';
import 'package:vstech_home_services/features/home/data/repositories/category_repository_impl.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/mocks.dart';

void main() {
  group('CategoryRemoteDataSource', () {
    late MockApiClient client;
    late CategoryRemoteDataSource dataSource;

    setUp(() {
      client = MockApiClient();
      dataSource = CategoryRemoteDataSource(client);
    });

    test('getCategories sends paging and decodes ids and money in both shapes', () async {
      when(
        () => client.get<PagedResponse<ServiceCategoryResponse>>(
          ApiEndpoints.serviceCategories,
          query: any(named: 'query'),
          decode: any(named: 'decode'),
        ),
      ).thenAnswer((invocation) async {
        final decode = invocation.namedArguments[#decode] as PagedResponse<ServiceCategoryResponse> Function(Object?);
        return ApiResponse(
          status: 200,
          message: '',
          data: decode(jsonFixture('home/categories_page.json')['data']),
          errorCode: null,
          timestamp: null,
        );
      });

      final page = await dataSource.getCategories(page: 1, size: 10);

      expect(page.content.first.id, '1');
      expect(page.content.first.basePrice, 200000);
      expect(page.content[1].basePrice, 150000);
      expect(page.content[2].isActive, isFalse);
      verify(
        () => client.get<PagedResponse<ServiceCategoryResponse>>(
          ApiEndpoints.serviceCategories,
          query: {'page': 1, 'size': 10},
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });
  });

  group('CategoryRepositoryImpl', () {
    late MockCategoryRemoteDataSource remote;
    late CategoryRepositoryImpl repository;

    PagedResponse<ServiceCategoryResponse> pageOf(List<ServiceCategoryResponse> items, {int page = 0, int pages = 1}) =>
        PagedResponse(content: items, page: page, size: 50, totalItems: items.length, totalPages: pages);

    setUp(() {
      remote = MockCategoryRemoteDataSource();
      repository = CategoryRepositoryImpl(remote);
    });

    test('returns active categories across every page', () async {
      when(() => remote.getCategories()).thenAnswer(
        (_) async => pageOf(const [ServiceCategoryResponse(id: '1', name: 'A', isActive: true)], pages: 2),
      );
      when(() => remote.getCategories(page: 1)).thenAnswer(
        (_) async => pageOf(const [
          ServiceCategoryResponse(id: '2', name: 'B'),
          ServiceCategoryResponse(id: '3', name: 'C', isActive: false),
        ], page: 1, pages: 2),
      );

      final result = await repository.getCategories();

      expect(
        (result as Ok<List<ServiceCategory>>).value.map((c) => c.id),
        ['1', '2'],
      );
    });

    test('maps errors to a Failure', () async {
      when(() => remote.getCategory('9')).thenThrow(
        const NetworkException(kind: NetworkErrorKind.server, errorCode: 'HS-404-0003', statusCode: 404),
      );

      final result = await repository.getCategory('9');

      expect(result, isA<Err<ServiceCategory>>().having((r) => r.failure.errorCode, 'code', 'HS-404-0003'));
    });
  });
}
