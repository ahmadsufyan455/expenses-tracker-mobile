import 'package:expense_tracker_mobile/core/errors/error_handler.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/datasources/remote/api_service.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/data/models/response/category_response.dart';
import 'package:expense_tracker_mobile/data/models/response/transaction_response.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MainRepository)
class MainRepositoryImpl implements MainRepository {
  final ApiService _apiService;

  MainRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, String>> createTransaction(NewTransactionRequest request) async {
    try {
      final response = await _apiService.createTransaction(request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<CategoryResponse>>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      return Right(response.data!);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<TransactionResponse>>> getTransactions(
    int page,
    int perPage,
    String sortBy,
    String sortOrder,
  ) async {
    try {
      final response = await _apiService.getTransactions(page, perPage, sortBy, sortOrder);
      return Right(response.data);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}
