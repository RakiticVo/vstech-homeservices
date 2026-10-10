import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_categories_use_case.dart';

part 'categories_state.dart';

/// Service catalogue for Customer Home and the Categories screen.
@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._getCategories) : super(const CategoriesInitialState());

  final GetCategoriesUseCase _getCategories;

  Future<void> load() async {
    emit(const CategoriesLoadingState());
    switch (await _getCategories()) {
      case Ok(:final value):
        emit(CategoriesLoadedState(value));
      case Err(:final failure):
        emit(CategoriesErrorState(failure));
    }
  }
}
