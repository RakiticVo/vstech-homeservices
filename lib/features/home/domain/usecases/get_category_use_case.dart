import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/domain/repositories/category_repository.dart';

@injectable
class GetCategoryUseCase {
  const GetCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  Future<Result<ServiceCategory>> call(String id) => _repository.getCategory(id);
}
