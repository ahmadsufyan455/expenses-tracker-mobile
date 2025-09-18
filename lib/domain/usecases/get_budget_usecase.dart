import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/domain/dto/budget_dto.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBudgetUsecase {
  final MainRepository _mainRepository;

  GetBudgetUsecase(this._mainRepository);

  Future<Either<Failure, List<BudgetDto>>> call() async {
    return await _mainRepository.getBudgets();
  }
}