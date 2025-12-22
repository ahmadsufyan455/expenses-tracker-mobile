import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/response/base_pagination_response.dart';
import 'package:expense_tracker_mobile/data/models/response/budget_response.dart';
import 'package:expense_tracker_mobile/domain/dto/total_active_budget_dto.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBudgetUsecase {
  final MainRepository _mainRepository;

  GetBudgetUsecase(this._mainRepository);

  Future<Either<Failure, BasePaginationResponse<BudgetResponse>>> call(
    int page,
    int perPage,
    String sortBy,
    String sortOrder,
    int? status,
  ) async {
    return await _mainRepository.getBudgets(page, perPage, sortBy, sortOrder, status);
  }

  Future<Either<Failure, TotalActiveBudgetDto>> callTotalActiveBudget() async {
    return await _mainRepository.getTotalActiveBudgets().then(
      (value) => value.map((response) => TotalActiveBudgetDto.fromResponse(response)),
    );
  }
}
