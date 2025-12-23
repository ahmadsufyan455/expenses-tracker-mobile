import 'package:json_annotation/json_annotation.dart';

part 'total_active_budget_response.g.dart';

@JsonSerializable()
class TotalActiveBudgetResponse {
  @JsonKey(name: 'total_active_budgets')
  final int totalActiveBudgets;
  @JsonKey(name: 'remaining_active_budgets')
  final int remainingActiveBugets;

  const TotalActiveBudgetResponse({required this.totalActiveBudgets, required this.remainingActiveBugets});

  factory TotalActiveBudgetResponse.fromJson(Map<String, dynamic> json) => _$TotalActiveBudgetResponseFromJson(json);
}
