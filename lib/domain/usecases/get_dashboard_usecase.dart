import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/domain/dto/dashboard_dto.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDashboardUsecase {
  final MainRepository _mainRepository;

  GetDashboardUsecase(this._mainRepository);

  Future<Either<Failure, DashboardDto>> call({
    String? month,
    int? transactionLimit,
    int? expenseLimit,
    int? budgetLimit,
  }) async {
    return await _mainRepository.getDashboard(
      month: month,
      transactionLimit: transactionLimit,
      expenseLimit: expenseLimit,
      budgetLimit: budgetLimit,
    );
  }
}
