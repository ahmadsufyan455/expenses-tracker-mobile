import 'package:json_annotation/json_annotation.dart';

part 'prediction_response.g.dart';

@JsonSerializable(createToJson: false)
class PredictionResponse {
  @JsonKey(name: 'daily_allowance')
  final int dailyAllowance;
  @JsonKey(name: 'remaining_budget')
  final int remainingBudget;
  @JsonKey(name: 'days_remaining')
  final int daysRemaining;
  @JsonKey(name: 'prediction_type')
  final String predictionType;

  PredictionResponse({
    required this.dailyAllowance,
    required this.remainingBudget,
    required this.daysRemaining,
    required this.predictionType,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) => _$PredictionResponseFromJson(json);
}
