import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/home/data/datasources/category_remote_data_source.dart';
import 'package:vstech_home_services/features/home/data/models/service_category_response.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/domain/repositories/category_repository.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._remote);

  final CategoryRemoteDataSource _remote;

  @override
  Future<Result<List<ServiceCategory>>> getCategories() => Result.guard(() async {
    final all = <ServiceCategoryResponse>[];
    var page = 0;
    while (true) {
      final response = await _remote.getCategories(page: page);
      all.addAll(response.content);
      if (!response.hasMore) break;
      page++;
    }
    return [
      for (final category in all)
        if (category.isActive ?? true) _toEntity(category),
    ];
  });

  @override
  Future<Result<ServiceCategory>> getCategory(String id) =>
      Result.guard(() async => _toEntity(await _remote.getCategory(id)));

  static ServiceCategory _toEntity(ServiceCategoryResponse r) => ServiceCategory(
    id: r.id,
    name: r.name,
    description: r.description,
    basePrice: r.basePrice,
    imageUrl: r.imageUrl,
  );
}
