import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';

abstract interface class CategoryRepository {
  /// Active categories only, in the order the backend returns them.
  Future<Result<List<ServiceCategory>>> getCategories();

  Future<Result<ServiceCategory>> getCategory(String id);
}
