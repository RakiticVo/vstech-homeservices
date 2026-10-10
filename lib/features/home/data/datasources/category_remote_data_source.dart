import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/features/home/data/models/service_category_response.dart';

/// `/api/v1/service-categories` (read-only — create/update/delete are admin endpoints).
@injectable
class CategoryRemoteDataSource {
  const CategoryRemoteDataSource(this._client);

  final ApiClient _client;

  Future<PagedResponse<ServiceCategoryResponse>> getCategories({int page = 0, int size = 50}) async {
    final response = await _client.get(
      ApiEndpoints.serviceCategories,
      query: {'page': page, 'size': size},
      decode: (json) => PagedResponse.fromJson(json! as Map<String, dynamic>, _decode),
    );
    return response.requireData;
  }

  Future<ServiceCategoryResponse> getCategory(String id) async {
    final response = await _client.get(ApiEndpoints.serviceCategory(id), decode: _decode);
    return response.requireData;
  }

  static ServiceCategoryResponse _decode(Object? json) =>
      ServiceCategoryResponse.fromJson(json! as Map<String, dynamic>);
}
