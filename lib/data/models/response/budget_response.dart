import 'package:expense_tracker_mobile/data/models/response/prediction_response.dart';
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
  @JsonKey(name: 'prediction')
  final PredictionResponse? prediction;

  BudgetResponse({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.predictionEnabled,
    this.predictionType,
    this.predictionDaysCount,
    this.prediction,
  });

  factory BudgetResponse.fromJson(Map<String, dynamic> json) => _$BudgetResponseFromJson(json);
}
