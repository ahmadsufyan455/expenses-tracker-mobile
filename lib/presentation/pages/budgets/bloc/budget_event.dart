part of 'budget_bloc.dart';

sealed class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object?> get props => [];
}

class GetBudgetEvent extends BudgetEvent {
  final int? status;
  const GetBudgetEvent({this.status});

  @override
  List<Object?> get props => [status];
}

class GetTotalActiveBudgtesEvent extends BudgetEvent {
  const GetTotalActiveBudgtesEvent();
}

class LoadMoreBudgetEvent extends BudgetEvent {
  final int? status;
  const LoadMoreBudgetEvent({this.status});

  @override
  List<Object?> get props => [status];
}

class CreateBudgetEvent extends BudgetEvent {
  final int categoryId;
  final int amount;
  final String startDate;
  final String endDate;
  final bool predictionEnabled;
  final String? predictionType;
  final int? predictionDaysCount;

  const CreateBudgetEvent({
    required this.categoryId,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.predictionEnabled,
    this.predictionType,
    this.predictionDaysCount,
  });

  @override
  List<Object?> get props => [
    categoryId,
    amount,
    startDate,
    endDate,
    predictionEnabled,
    predictionType,
    predictionDaysCount,
  ];
}

class UpdateBudgetEvent extends BudgetEvent {
  final int id;
  final int categoryId;
  final int amount;
  final String startDate;
  final String endDate;
  final bool predictionEnabled;
  final String? predictionType;
  final int? predictionDaysCount;

  const UpdateBudgetEvent({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.predictionEnabled,
    this.predictionType,
    this.predictionDaysCount,
  });

  @override
  List<Object?> get props => [
    id,
    categoryId,
    amount,
    startDate,
    endDate,
    predictionEnabled,
    predictionType,
    predictionDaysCount,
  ];
}

class DeleteBudgetEvent extends BudgetEvent {
  final int id;

  const DeleteBudgetEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
