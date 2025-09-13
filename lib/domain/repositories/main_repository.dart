import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/data/models/response/category_response.dart';
import 'package:expense_tracker_mobile/data/models/response/transaction_response.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MainRepository {
  Future<Either<Failure, String>> createTransaction(NewTransactionRequest request);
  Future<Either<Failure, List<CategoryResponse>>> getCategories();
  Future<Either<Failure, List<TransactionResponse>>> getTransactions(
    int page,
    int perPage,
    String sortBy,
    String sortOrder,
  );
}
