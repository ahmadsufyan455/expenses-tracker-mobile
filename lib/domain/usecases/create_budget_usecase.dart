import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/budget_request.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateBudgetUsecase {
  final MainRepository _mainRepository;

  CreateBudgetUsecase(this._mainRepository);

  Future<Either<Failure, String>> call(BudgetRequest request) async {
    return await _mainRepository.createBudget(request);
  }
}