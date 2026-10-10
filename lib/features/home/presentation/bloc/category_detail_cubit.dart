import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_category_use_case.dart';

part 'category_detail_state.dart';

/// One service category for the Service Detail screen (`GET /service-categories/{id}`).
@injectable
class CategoryDetailCubit extends Cubit<CategoryDetailState> {
  CategoryDetailCubit(this._getCategory) : super(const CategoryDetailInitialState());

  final GetCategoryUseCase _getCategory;

  Future<void> load(String id) async {
    emit(const CategoryDetailLoadingState());
    switch (await _getCategory(id)) {
      case Ok(:final value):
        emit(CategoryDetailLoadedState(value));
      case Err(:final failure):
        emit(CategoryDetailErrorState(failure));
    }
  }
}
