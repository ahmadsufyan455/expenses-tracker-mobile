import 'package:expense_tracker_mobile/core/errors/error_handler.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/datasources/remote/api_service.dart';
import 'package:expense_tracker_mobile/data/models/request/budget_request.dart';
import 'package:expense_tracker_mobile/data/models/request/category_request.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/data/models/response/base_pagination_response.dart';
import 'package:expense_tracker_mobile/data/models/response/budget_response.dart';
import 'package:expense_tracker_mobile/data/models/response/category_response.dart';
import 'package:expense_tracker_mobile/data/models/response/total_active_budget_response.dart';
import 'package:expense_tracker_mobile/data/models/response/transaction_response.dart';
import 'package:expense_tracker_mobile/domain/dto/dashboard_dto.dart';
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

  @override
  Future<Either<Failure, void>> deleteTransaction(int id) async {
    try {
      await _apiService.deleteTransaction(id);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateTransaction(int id, NewTransactionRequest request) async {
    try {
      final response = await _apiService.updateTransaction(id, request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> createCategory(CategoryRequest request) async {
    try {
      final response = await _apiService.createCategory(request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateCategory(int id, CategoryRequest request) async {
    try {
      final response = await _apiService.updateCategory(id, request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(int id) async {
    try {
      await _apiService.deleteCategory(id);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, BasePaginationResponse<BudgetResponse>>> getBudgets(
    int page,
    int perPage,
    String sortBy,
    String sortOrder,
    int? status,
  ) async {
    try {
      final response = await _apiService.getBudgets(page, perPage, sortBy, sortOrder, status);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> createBudget(BudgetRequest request) async {
    try {
      final response = await _apiService.createBudget(request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateBudget(int id, BudgetRequest request) async {
    try {
      final response = await _apiService.updateBudget(id, request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBudget(int id) async {
    try {
      await _apiService.deleteBudget(id);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, DashboardDto>> getDashboard({
    String? month,
    String? startDate,
    String? endDate,
    int? transactionLimit,
    int? expenseLimit,
    int? budgetLimit,
  }) async {
    try {
      final response = await _apiService.getDashboard(
        month: month,
        startDate: startDate,
        endDate: endDate,
        transactionLimit: transactionLimit,
        expenseLimit: expenseLimit,
        budgetLimit: budgetLimit,
      );
      final dashboard = DashboardDto.fromResponse(response.data!);
      return Right(dashboard);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, TotalActiveBudgetResponse>> getTotalActiveBudgets() async {
    try {
      final response = await _apiService.getTotalActiveBudgets();
      return Right(response.data!);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}
