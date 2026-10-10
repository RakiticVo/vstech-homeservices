part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {
  const CategoriesState();
}

final class CategoriesInitialState extends CategoriesState {
  const CategoriesInitialState();
}

final class CategoriesLoadingState extends CategoriesState {
  const CategoriesLoadingState();
}

final class CategoriesLoadedState extends CategoriesState {
  const CategoriesLoadedState(this.categories);

  final List<ServiceCategory> categories;

  @override
  bool operator ==(Object other) => other is CategoriesLoadedState && listEquals(other.categories, categories);

  @override
  int get hashCode => Object.hashAll(categories);
}

final class CategoriesErrorState extends CategoriesState {
  const CategoriesErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is CategoriesErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
