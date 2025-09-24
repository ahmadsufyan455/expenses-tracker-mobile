// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(
  Map<String, dynamic> json,
) => DashboardResponse(
  period: json['period'] as String,
  summary: DashboardSummaryResponse.fromJson(
    json['summary'] as Map<String, dynamic>,
  ),
  budgets: (json['budgets'] as List<dynamic>)
      .map((e) => DashboardBudgetResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
  recentTransactions: (json['recent_transactions'] as List<dynamic>)
      .map(
        (e) => DashboardTransactionResponse.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  topExpenses: (json['top_expenses'] as List<dynamic>)
      .map(
        (e) => DashboardTopExpenseResponse.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

DashboardSummaryResponse _$DashboardSummaryResponseFromJson(
  Map<String, dynamic> json,
) => DashboardSummaryResponse(
  totalIncome: (json['total_income'] as num).toInt(),
  totalExpenses: (json['total_expenses'] as num).toInt(),
  netBalance: (json['net_balance'] as num).toInt(),
  savingsRate: (json['savings_rate'] as num).toDouble(),
);

DashboardBudgetResponse _$DashboardBudgetResponseFromJson(
  Map<String, dynamic> json,
) => DashboardBudgetResponse(
  category: json['category'] as String,
  spent: (json['spent'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  percentage: (json['percentage'] as num).toDouble(),
);

DashboardTransactionResponse _$DashboardTransactionResponseFromJson(
  Map<String, dynamic> json,
) => DashboardTransactionResponse(
  id: (json['id'] as num).toInt(),
  amount: (json['amount'] as num).toInt(),
  type: json['type'] as String,
  category: json['category'] as String,
  date: json['date'] as String,
);

DashboardTopExpenseResponse _$DashboardTopExpenseResponseFromJson(
  Map<String, dynamic> json,
) => DashboardTopExpenseResponse(
  category: json['category'] as String,
  amount: (json['amount'] as num).toInt(),
  percentage: (json['percentage'] as num).toDouble(),
);
