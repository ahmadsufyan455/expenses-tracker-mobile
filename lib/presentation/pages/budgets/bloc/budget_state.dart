part of 'budget_bloc.dart';

class BudgetStateData extends Equatable {
  final List<BudgetDto> budgets;
  final List<CategoryDto> categories;
  final TotalActiveBudgetDto activeBudget;
  final String message;
  final bool hasMoreData;
  final bool isLoadingMore;

  const BudgetStateData({
    this.budgets = const [],
    this.categories = const [],
    this.activeBudget = const TotalActiveBudgetDto(),
    this.message = '',
    this.hasMoreData = false,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props => [budgets, categories, message, hasMoreData, isLoadingMore];

  BudgetStateData copyWith({
    List<BudgetDto>? budgets,
    List<CategoryDto>? categories,
    TotalActiveBudgetDto? activeBudget,
    String? message,
    bool? hasMoreData,
    bool? isLoadingMore,
  }) {
    return BudgetStateData(
      budgets: budgets ?? this.budgets,
      categories: categories ?? this.categories,
      activeBudget: activeBudget ?? this.activeBudget,
      message: message ?? this.message,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

sealed class BudgetState extends Equatable {
  final BudgetStateData data;
  const BudgetState({required this.data});

  @override
  List<Object> get props => [data];
}

final class BudgetInitial extends BudgetState {
  BudgetInitial() : super(data: BudgetStateData());
}

/// get budget
final class GetBudgetLoading extends BudgetState {
  const GetBudgetLoading({required super.data});
}

final class GetBudgetSuccess extends BudgetState {
  const GetBudgetSuccess({required super.data});
}

final class GetBudgetFailure extends BudgetState {
  final Failure failure;

  const GetBudgetFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}

/// create budget
final class CreateBudgetLoading extends BudgetState {
  const CreateBudgetLoading({required super.data});
}

final class CreateBudgetSuccess extends BudgetState {
  const CreateBudgetSuccess({required super.data});
}

final class CreateBudgetFailure extends BudgetState {
  final Failure failure;

  const CreateBudgetFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}

/// update budget
final class UpdateBudgetLoading extends BudgetState {
  const UpdateBudgetLoading({required super.data});
}

final class UpdateBudgetSuccess extends BudgetState {
  const UpdateBudgetSuccess({required super.data});
}

final class UpdateBudgetFailure extends BudgetState {
  final Failure failure;

  const UpdateBudgetFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}

/// delete budget
final class DeleteBudgetLoading extends BudgetState {
  const DeleteBudgetLoading({required super.data});
}

final class DeleteBudgetSuccess extends BudgetState {
  const DeleteBudgetSuccess({required super.data});
}

final class DeleteBudgetFailure extends BudgetState {
  final Failure failure;

  const DeleteBudgetFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}

final class GetTotalActiveBudgetsLoading extends BudgetState {
  const GetTotalActiveBudgetsLoading({required super.data});
}

final class GetTotalActiveBudgetsSuccess extends BudgetState {
  const GetTotalActiveBudgetsSuccess({required super.data});
}

final class GetTotalActiveBudgetsFailure extends BudgetState {
  final Failure failure;
  const GetTotalActiveBudgetsFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}
