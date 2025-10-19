import 'package:expense_tracker_mobile/core/enums/budget_enums.dart';
import 'package:expense_tracker_mobile/data/models/response/budget_response.dart';
import 'package:expense_tracker_mobile/domain/dto/prediction_dto.dart';

class BudgetDto {
  final int id;
  final int categoryId;
  final int amount;
  final int status;
  final DateTime startDate;
  final DateTime endDate;
  final int remainingBudget;
  final bool predictionEnabled;
  final PredictionType? predictionType;
  final int? predictionDaysCount;
  final PredictionDto? prediction;

  BudgetDto({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.remainingBudget,
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
      status: response.status,
      startDate: DateTime.parse(response.startDate),
      endDate: DateTime.parse(response.endDate),
      remainingBudget: response.remainingBudget,
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

/// Extension methods for BudgetDto to handle status and lifecycle
extension BudgetDtoExtension on BudgetDto {
  /// Get the current status of the budget based on dates
  BudgetStatus get budgetStatus {
    if (status == 2) {
      return BudgetStatus.upcoming;
    } else if (status == 3) {
      return BudgetStatus.expired;
    } else {
      return BudgetStatus.active;
    }
  }

  /// Check if budget is currently active
  bool get isActive => budgetStatus == BudgetStatus.active;

  /// Check if budget has expired
  bool get isExpired => budgetStatus == BudgetStatus.expired;

  /// Check if budget is upcoming
  bool get isUpcoming => budgetStatus == BudgetStatus.upcoming;

  /// Check if budget is ending soon (within 3 days)
  bool get isEndingSoon {
    if (!isActive) return false;
    final now = DateTime.now();
    final daysRemaining = endDate.difference(now).inDays;
    return daysRemaining <= 3 && daysRemaining >= 0;
  }

  /// Get days remaining in the budget period (-1 if expired, 0 if today is last day)
  int get daysRemaining {
    final now = DateTime.now();
    final nowDateOnly = DateTime(now.year, now.month, now.day);
    final endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);
    return endDateOnly.difference(nowDateOnly).inDays;
  }

  /// Get total duration of budget period in days
  int get totalDays {
    final startDateOnly = DateTime(startDate.year, startDate.month, startDate.day);
    final endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);
    return endDateOnly.difference(startDateOnly).inDays + 1; // +1 to include both start and end dates
  }
}
