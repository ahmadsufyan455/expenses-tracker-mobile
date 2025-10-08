import 'package:json_annotation/json_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable(createToJson: false)
class DashboardResponse {
  @JsonKey(name: 'period')
  final String period;

  @JsonKey(name: 'summary')
  final DashboardSummaryResponse summary;

  @JsonKey(name: 'budgets')
  final List<DashboardBudgetResponse> budgets;

  @JsonKey(name: 'recent_transactions')
  final List<DashboardTransactionResponse> recentTransactions;

  @JsonKey(name: 'top_expenses')
  final List<DashboardTopExpenseResponse> topExpenses;

  const DashboardResponse({
    required this.period,
    required this.summary,
    required this.budgets,
    required this.recentTransactions,
    required this.topExpenses,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) => _$DashboardResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardSummaryResponse {
  @JsonKey(name: 'total_income')
  final int totalIncome;

  @JsonKey(name: 'total_expenses')
  final int totalExpenses;

  @JsonKey(name: 'total_expenses_today')
  final int totalExpensesToday;

  @JsonKey(name: 'net_balance')
  final int netBalance;

  @JsonKey(name: 'savings_rate')
  final double savingsRate;

  const DashboardSummaryResponse({
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalExpensesToday,
    required this.netBalance,
    required this.savingsRate,
  });

  factory DashboardSummaryResponse.fromJson(Map<String, dynamic> json) => _$DashboardSummaryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardBudgetResponse {
  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'spent')
  final int spent;

  @JsonKey(name: 'limit')
  final int limit;

  @JsonKey(name: 'percentage')
  final double percentage;

  const DashboardBudgetResponse({
    required this.category,
    required this.spent,
    required this.limit,
    required this.percentage,
  });

  factory DashboardBudgetResponse.fromJson(Map<String, dynamic> json) => _$DashboardBudgetResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardTransactionResponse {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'amount')
  final int amount;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'transaction_date')
  final String date;

  const DashboardTransactionResponse({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  factory DashboardTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardTransactionResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardTopExpenseResponse {
  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'amount')
  final int amount;

  @JsonKey(name: 'percentage')
  final double percentage;

  const DashboardTopExpenseResponse({required this.category, required this.amount, required this.percentage});

  factory DashboardTopExpenseResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardTopExpenseResponseFromJson(json);
}
