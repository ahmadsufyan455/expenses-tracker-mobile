import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/budget_request.dart';
import 'package:expense_tracker_mobile/data/models/request/category_request.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/data/models/response/base_pagination_response.dart';
import 'package:expense_tracker_mobile/data/models/response/budget_response.dart';
import 'package:expense_tracker_mobile/data/models/response/category_response.dart';
import 'package:expense_tracker_mobile/data/models/response/transaction_response.dart';
import 'package:expense_tracker_mobile/domain/dto/dashboard_dto.dart';
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

  Future<Either<Failure, void>> deleteTransaction(int id);

  Future<Either<Failure, String>> updateTransaction(int id, NewTransactionRequest request);

  Future<Either<Failure, String>> createCategory(CategoryRequest request);

  Future<Either<Failure, String>> updateCategory(int id, CategoryRequest request);

  Future<Either<Failure, void>> deleteCategory(int id);

  Future<Either<Failure, BasePaginationResponse<BudgetResponse>>> getBudgets(
    int page,
    int perPage,
    String sortBy,
    String sortOrder,
  );

  Future<Either<Failure, String>> createBudget(BudgetRequest request);

  Future<Either<Failure, String>> updateBudget(int id, BudgetRequest request);

  Future<Either<Failure, void>> deleteBudget(int id);

  Future<Either<Failure, DashboardDto>> getDashboard({
    String? month,
    int? transactionLimit,
    int? expenseLimit,
    int? budgetLimit,
  });
}
