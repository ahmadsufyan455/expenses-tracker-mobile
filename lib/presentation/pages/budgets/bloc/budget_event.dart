part of 'budget_bloc.dart';

sealed class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class GetBudgetEvent extends BudgetEvent {
  const GetBudgetEvent();

  @override
  List<Object> get props => [];
}

class CreateBudgetEvent extends BudgetEvent {
  final int categoryId;
  final int amount;
  final String month;

  const CreateBudgetEvent({
    required this.categoryId,
    required this.amount,
    required this.month,
  });

  @override
  List<Object> get props => [categoryId, amount, month];
}

class UpdateBudgetEvent extends BudgetEvent {
  final int id;
  final int categoryId;
  final int amount;
  final String month;

  const UpdateBudgetEvent({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.month,
  });

  @override
  List<Object> get props => [id, categoryId, amount, month];
}

class DeleteBudgetEvent extends BudgetEvent {
  final int id;

  const DeleteBudgetEvent({required this.id});

  @override
  List<Object> get props => [id];
}