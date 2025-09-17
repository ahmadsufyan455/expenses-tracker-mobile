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
