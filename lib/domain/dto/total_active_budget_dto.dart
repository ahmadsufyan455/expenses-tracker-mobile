import 'package:expense_tracker_mobile/data/models/response/total_active_budget_response.dart';

class TotalActiveBudgetDto {
  final int totalActiveBudgets;
  final int remainingActiveBugets;

  const TotalActiveBudgetDto({this.totalActiveBudgets = 0, this.remainingActiveBugets = 0});

  factory TotalActiveBudgetDto.fromResponse(TotalActiveBudgetResponse response) => TotalActiveBudgetDto(
    totalActiveBudgets: response.totalActiveBudgets,
    remainingActiveBugets: response.remainingActiveBugets,
  );
}
