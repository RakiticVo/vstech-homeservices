part of 'category_detail_cubit.dart';

@immutable
sealed class CategoryDetailState {
  const CategoryDetailState();
}

final class CategoryDetailInitialState extends CategoryDetailState {
  const CategoryDetailInitialState();
}

final class CategoryDetailLoadingState extends CategoryDetailState {
  const CategoryDetailLoadingState();
}

final class CategoryDetailLoadedState extends CategoryDetailState {
  const CategoryDetailLoadedState(this.category);

  final ServiceCategory category;

  @override
  bool operator ==(Object other) => other is CategoryDetailLoadedState && other.category == category;

  @override
  int get hashCode => category.hashCode;
}

final class CategoryDetailErrorState extends CategoryDetailState {
  const CategoryDetailErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is CategoryDetailErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
