part of 'category_bloc.dart';

class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoryEvent extends CategoryEvent {}

class CreateCategoryEvent extends CategoryEvent {
  final String name;

  const CreateCategoryEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class UpdateCategoryEvent extends CategoryEvent {
  final int id;
  final String name;

  const UpdateCategoryEvent({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class DeleteCategoryEvent extends CategoryEvent {
  final int id;

  const DeleteCategoryEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
