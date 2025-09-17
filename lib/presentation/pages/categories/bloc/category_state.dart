part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryDto> categories;

  const CategoryLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoryError extends CategoryState {
  final Failure failure;

  const CategoryError({required this.failure});

  @override
  List<Object?> get props => [failure];
}

/// create category state

class CreateCategoryLoading extends CategoryState {}

class CreateCategorySuccess extends CategoryState {
  final String message;

  const CreateCategorySuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateCategoryError extends CategoryState {
  final Failure failure;

  const CreateCategoryError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
