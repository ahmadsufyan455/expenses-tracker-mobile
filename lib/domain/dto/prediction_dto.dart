import 'package:expense_tracker_mobile/core/enums/budget_enums.dart';
import 'package:expense_tracker_mobile/data/models/response/prediction_response.dart';

class PredictionDto {
  final int dailyAllowance;
  final int remainingBudget;
  final int daysRemaining;
  final PredictionType predictionType;

  PredictionDto({
    required this.dailyAllowance,
    required this.remainingBudget,
    required this.daysRemaining,
    required this.predictionType,
  });

  factory PredictionDto.fromResponse(PredictionResponse response) {
    return PredictionDto(
      dailyAllowance: response.dailyAllowance,
      remainingBudget: response.remainingBudget,
      daysRemaining: response.daysRemaining,
      predictionType: PredictionType.fromString(response.predictionType),
    );
  }
}
