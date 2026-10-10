import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/categories_cubit.dart';
import 'package:vstech_home_services/features/home/presentation/bloc/category_detail_cubit.dart';

import '../../../fixtures/booking/booking_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);

void main() {
  late MockGetCategoriesUseCase getCategories;
  late MockGetCategoryUseCase getCategory;

  setUp(() {
    getCategories = MockGetCategoriesUseCase();
    getCategory = MockGetCategoryUseCase();
  });

  blocTest<CategoriesCubit, CategoriesState>(
    'load emits the catalogue',
    setUp: () => when(() => getCategories()).thenAnswer((_) async => const Ok([acCategory, cleanCategory])),
    build: () => CategoriesCubit(getCategories),
    act: (cubit) => cubit.load(),
    expect: () => [const CategoriesLoadingState(), const CategoriesLoadedState([acCategory, cleanCategory])],
  );

  blocTest<CategoriesCubit, CategoriesState>(
    'load failure is emitted',
    setUp: () => when(() => getCategories()).thenAnswer((_) async => const Err(_offline)),
    build: () => CategoriesCubit(getCategories),
    act: (cubit) => cubit.load(),
    expect: () => [const CategoriesLoadingState(), const CategoriesErrorState(_offline)],
  );

  blocTest<CategoryDetailCubit, CategoryDetailState>(
    'load emits one category',
    setUp: () => when(() => getCategory('1')).thenAnswer((_) async => const Ok<ServiceCategory>(acCategory)),
    build: () => CategoryDetailCubit(getCategory),
    act: (cubit) => cubit.load('1'),
    expect: () => [const CategoryDetailLoadingState(), const CategoryDetailLoadedState(acCategory)],
  );

  blocTest<CategoryDetailCubit, CategoryDetailState>(
    'load failure is emitted',
    setUp: () => when(() => getCategory('1')).thenAnswer((_) async => const Err(_offline)),
    build: () => CategoryDetailCubit(getCategory),
    act: (cubit) => cubit.load('1'),
    expect: () => [const CategoryDetailLoadingState(), const CategoryDetailErrorState(_offline)],
  );
}
