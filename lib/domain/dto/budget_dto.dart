import 'package:expense_tracker_mobile/core/enums/budget_enums.dart';
import 'package:expense_tracker_mobile/data/models/response/budget_response.dart';
import 'package:expense_tracker_mobile/domain/dto/prediction_dto.dart';

class BudgetDto {
  final int id;
  final int categoryId;
  final int amount;
  final DateTime startDate;
  final DateTime endDate;
  final bool predictionEnabled;
  final PredictionType? predictionType;
  final int? predictionDaysCount;
  final PredictionDto? prediction;

  BudgetDto({
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

  factory BudgetDto.fromResponse(BudgetResponse response) {
    return BudgetDto(
      id: response.id,
      categoryId: response.categoryId,
      amount: response.amount,
      startDate: DateTime.parse(response.startDate),
      endDate: DateTime.parse(response.endDate),
      predictionEnabled: response.predictionEnabled,
      predictionType: response.predictionType != null ? PredictionType.fromString(response.predictionType!) : null,
      predictionDaysCount: response.predictionDaysCount,
      prediction: response.prediction != null ? PredictionDto.fromResponse(response.prediction!) : null,
    );
  }

  static List<BudgetDto> fromResponseList(List<BudgetResponse> response) {
    return response.map((budget) => BudgetDto.fromResponse(budget)).toList();
  }
}
