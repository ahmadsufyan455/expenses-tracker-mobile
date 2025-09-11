import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateTransactionUsecase {
  final MainRepository _mainRepository;

  CreateTransactionUsecase(this._mainRepository);

  Future<Either<Failure, String>> call(NewTransactionRequest request) async {
    return await _mainRepository.createTransaction(request);
  }
}
