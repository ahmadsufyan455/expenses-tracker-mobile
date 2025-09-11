part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final double totalIncome;
  final double totalExpense;
  final String currentFilter;
  final List<BudgetItem> recentBudgets;
  final List<TransactionItem> recentTransactions;

  const HomeLoaded({
    required this.totalIncome,
    required this.totalExpense,
    required this.currentFilter,
    required this.recentBudgets,
    required this.recentTransactions,
  });

  @override
  List<Object> get props => [
        totalIncome,
        totalExpense,
        currentFilter,
        recentBudgets,
        recentTransactions,
      ];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

// Data classes for mock data
class BudgetItem extends Equatable {
  final String name;
  final double allocated;
  final double used;
  final String category;

  const BudgetItem({
    required this.name,
    required this.allocated,
    required this.used,
    required this.category,
  });

  double get percentage => allocated > 0 ? (used / allocated * 100) : 0;
  bool get isOverBudget => used > allocated;

  @override
  List<Object> get props => [name, allocated, used, category];
}

class TransactionItem extends Equatable {
  final String id;
  final double amount;
  final String description;
  final String category;
  final DateTime date;
  final bool isExpense;

  const TransactionItem({
    required this.id,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.isExpense,
  });

  @override
  List<Object> get props => [id, amount, description, category, date, isExpense];
}