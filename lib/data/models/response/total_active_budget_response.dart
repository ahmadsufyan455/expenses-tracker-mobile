import 'package:json_annotation/json_annotation.dart';

part 'total_active_budget_response.g.dart';

@JsonSerializable()
class TotalActiveBudgetResponse {
  @JsonKey(name: 'total_active_budgets')
  final int totalActiveBudgets;

  const TotalActiveBudgetResponse({required this.totalActiveBudgets});

  factory TotalActiveBudgetResponse.fromJson(Map<String, dynamic> json) => _$TotalActiveBudgetResponseFromJson(json);
}
