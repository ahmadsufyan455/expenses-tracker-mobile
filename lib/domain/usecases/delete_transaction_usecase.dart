import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteTransactionUsecase {
  final MainRepository _mainRepository;

  DeleteTransactionUsecase(this._mainRepository);

  Future<Either<Failure, void>> call(int id) async {
    return await _mainRepository.deleteTransaction(id);
  }
}
