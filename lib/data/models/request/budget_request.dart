import 'package:json_annotation/json_annotation.dart';

part 'budget_request.g.dart';

@JsonSerializable()
class BudgetRequest {
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'amount')
  final int amount;
  @JsonKey(name: 'month')
  final String month;

  BudgetRequest({
    required this.categoryId,
    required this.amount,
    required this.month,
  });

  factory BudgetRequest.fromJson(Map<String, dynamic> json) =>
      _$BudgetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetRequestToJson(this);
}