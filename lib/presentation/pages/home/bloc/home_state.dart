part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final int totalIncome;
  final int totalExpense;
  final int netBalance;
  final double savingsRate;
  final String currentFilter;
  final List<BudgetItem> recentBudgets;
  final List<TransactionItem> recentTransactions;
  final List<TopExpenseItem> topExpenses;

  const HomeLoaded({
    required this.totalIncome,
    required this.totalExpense,
    required this.netBalance,
    required this.savingsRate,
    required this.currentFilter,
    required this.recentBudgets,
    required this.recentTransactions,
    required this.topExpenses,
  });

  @override
  List<Object> get props => [
    totalIncome,
    totalExpense,
    netBalance,
    savingsRate,
    currentFilter,
    recentBudgets,
    recentTransactions,
    topExpenses,
  ];
}

final class HomeError extends HomeState {
  final String filter;
  final String message;

  const HomeError({required this.message, required this.filter});

  @override
  List<Object> get props => [message, filter];
}

// Data classes for mock data
class BudgetItem extends Equatable {
  final String name;
  final int allocated;
  final int used;
  final String category;

  const BudgetItem({required this.name, required this.allocated, required this.used, required this.category});

  double get percentage => allocated > 0 ? (used / allocated * 100) : 0;
  bool get isOverBudget => used > allocated;

  @override
  List<Object> get props => [name, allocated, used, category];
}

class TransactionItem extends Equatable {
  final String id;
  final int amount;
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

class TopExpenseItem extends Equatable {
  final String category;
  final int amount;
  final double percentage;

  const TopExpenseItem({required this.category, required this.amount, required this.percentage});

  @override
  List<Object> get props => [category, amount, percentage];
}
