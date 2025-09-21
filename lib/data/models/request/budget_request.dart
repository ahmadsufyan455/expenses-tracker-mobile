import 'package:json_annotation/json_annotation.dart';

part 'budget_request.g.dart';

@JsonSerializable()
class BudgetRequest {
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'amount')
  final int amount;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'prediction_enabled')
  final bool predictionEnabled;
  @JsonKey(name: 'prediction_type')
  final String? predictionType;
  @JsonKey(name: 'prediction_days_count')
  final int? predictionDaysCount;

  BudgetRequest({
    required this.categoryId,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.predictionEnabled,
    this.predictionType,
    this.predictionDaysCount,
  });

  factory BudgetRequest.fromJson(Map<String, dynamic> json) =>
      _$BudgetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetRequestToJson(this);
}