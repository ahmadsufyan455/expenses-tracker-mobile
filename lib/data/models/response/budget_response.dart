import 'package:json_annotation/json_annotation.dart';

part 'budget_response.g.dart';

@JsonSerializable(createToJson: false)
class BudgetResponse {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'amount')
  final int amount;
  @JsonKey(name: 'month')
  final String month;

  BudgetResponse({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.month,
  });

  factory BudgetResponse.fromJson(Map<String, dynamic> json) =>
      _$BudgetResponseFromJson(json);
}