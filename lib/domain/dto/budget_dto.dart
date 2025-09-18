import 'package:expense_tracker_mobile/data/models/response/budget_response.dart';

class BudgetDto {
  final int id;
  final int categoryId;
  final int amount;
  final String month;

  BudgetDto({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.month,
  });

  factory BudgetDto.fromResponse(BudgetResponse response) {
    return BudgetDto(
      id: response.id,
      categoryId: response.categoryId,
      amount: response.amount,
      month: response.month,
    );
  }

  static List<BudgetDto> fromResponseList(List<BudgetResponse> response) {
    return response.map((budget) => BudgetDto.fromResponse(budget)).toList();
  }
}