import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteBudgetUsecase {
  final MainRepository _mainRepository;

  DeleteBudgetUsecase(this._mainRepository);

  Future<Either<Failure, String>> call(int id) async {
    return await _mainRepository.deleteBudget(id);
  }
}