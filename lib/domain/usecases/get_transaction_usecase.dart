import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/domain/dto/transaction_dto.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTransactionUsecase {
  final MainRepository _mainRepository;

  GetTransactionUsecase(this._mainRepository);

  Future<Either<Failure, List<TransactionDto>>> call(int page, int perPage, String sortBy, String sortOrder) async {
    return await _mainRepository
        .getTransactions(page, perPage, sortBy, sortOrder)
        .then((response) => response.map(TransactionDto.fromResponseList));
  }
}
