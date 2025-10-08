import 'package:expense_tracker_mobile/data/models/response/dashboard_response.dart';

class DashboardDto {
  final String period;
  final DashboardSummaryDto summary;
  final List<DashboardBudgetDto> budgets;
  final List<DashboardTransactionDto> recentTransactions;
  final List<DashboardTopExpenseDto> topExpenses;

  DashboardDto({
    required this.period,
    required this.summary,
    required this.budgets,
    required this.recentTransactions,
    required this.topExpenses,
  });

  factory DashboardDto.fromResponse(DashboardResponse response) {
    return DashboardDto(
      period: response.period,
      summary: DashboardSummaryDto.fromResponse(response.summary),
      budgets: DashboardBudgetDto.fromResponseList(response.budgets),
      recentTransactions: DashboardTransactionDto.fromResponseList(response.recentTransactions),
      topExpenses: DashboardTopExpenseDto.fromResponseList(response.topExpenses),
    );
  }
}

class DashboardSummaryDto {
  final int totalIncome;
  final int totalExpenses;
  final int totalExpensesToday;
  final int netBalance;
  final double savingsRate;

  DashboardSummaryDto({
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalExpensesToday,
    required this.netBalance,
    required this.savingsRate,
  });

  factory DashboardSummaryDto.fromResponse(DashboardSummaryResponse response) {
    return DashboardSummaryDto(
      totalIncome: response.totalIncome,
      totalExpenses: response.totalExpenses,
      totalExpensesToday: response.totalExpensesToday,
      netBalance: response.netBalance,
      savingsRate: response.savingsRate,
    );
  }
}

class DashboardBudgetDto {
  final String category;
  final int spent;
  final int limit;
  final double percentage;

  DashboardBudgetDto({required this.category, required this.spent, required this.limit, required this.percentage});

  bool get isOverBudget => spent > limit;

  factory DashboardBudgetDto.fromResponse(DashboardBudgetResponse response) {
    return DashboardBudgetDto(
      category: response.category,
      spent: response.spent,
      limit: response.limit,
      percentage: response.percentage,
    );
  }

  static List<DashboardBudgetDto> fromResponseList(List<DashboardBudgetResponse> response) {
    return response.map((budget) => DashboardBudgetDto.fromResponse(budget)).toList();
  }
}

class DashboardTransactionDto {
  final int id;
  final int amount;
  final String type;
  final String category;
  final DateTime date;

  DashboardTransactionDto({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  bool get isExpense => type == 'expense';

  factory DashboardTransactionDto.fromResponse(DashboardTransactionResponse response) {
    return DashboardTransactionDto(
      id: response.id,
      amount: response.amount,
      type: response.type,
      category: response.category,
      date: DateTime.parse(response.date),
    );
  }

  static List<DashboardTransactionDto> fromResponseList(List<DashboardTransactionResponse> response) {
    return response.map((transaction) => DashboardTransactionDto.fromResponse(transaction)).toList();
  }
}

class DashboardTopExpenseDto {
  final String category;
  final int amount;
  final double percentage;

  DashboardTopExpenseDto({required this.category, required this.amount, required this.percentage});

  factory DashboardTopExpenseDto.fromResponse(DashboardTopExpenseResponse response) {
    return DashboardTopExpenseDto(
      category: response.category,
      amount: response.amount,
      percentage: response.percentage,
    );
  }

  static List<DashboardTopExpenseDto> fromResponseList(List<DashboardTopExpenseResponse> response) {
    return response.map((expense) => DashboardTopExpenseDto.fromResponse(expense)).toList();
  }
}
