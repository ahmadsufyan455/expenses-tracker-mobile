import "package:dio/dio.dart";
import 'package:expense_tracker_mobile/data/models/request/budget_request.dart';
import 'package:expense_tracker_mobile/data/models/request/category_request.dart';
import 'package:expense_tracker_mobile/data/models/request/change_password_request.dart';
import 'package:expense_tracker_mobile/data/models/request/login_request.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/data/models/request/register_request.dart';
import 'package:expense_tracker_mobile/data/models/request/update_profile_request.dart';
import 'package:expense_tracker_mobile/data/models/response/base_pagination_response.dart';
import 'package:expense_tracker_mobile/data/models/response/base_response.dart';
import 'package:expense_tracker_mobile/data/models/response/budget_response.dart';
import 'package:expense_tracker_mobile/data/models/response/category_response.dart';
import 'package:expense_tracker_mobile/data/models/response/dashboard_response.dart';
import 'package:expense_tracker_mobile/data/models/response/login_response.dart';
import 'package:expense_tracker_mobile/data/models/response/profile_response.dart';
import 'package:expense_tracker_mobile/data/models/response/transaction_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@lazySingleton
@RestApi()
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio, {@Named('baseUrl') String? baseUrl}) = _ApiService;

  /// Authentication Endpoints

  @POST('/auth/login')
  Future<BaseResponse<LoginResponse>> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<BaseResponse> register(@Body() RegisterRequest request);

  /// Transaction Endpoints

  @POST('/transactions/')
  Future<BaseResponse> createTransaction(@Body() NewTransactionRequest request);

  @GET('/transactions/')
  Future<BasePaginationResponse<TransactionResponse>> getTransactions(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('sort_by') String sortBy,
    @Query('sort_order') String sortOrder,
  );

  @PUT('/transactions/{id}')
  Future<BaseResponse> updateTransaction(@Path('id') int id, @Body() NewTransactionRequest request);

  @DELETE('/transactions/{id}')
  Future<void> deleteTransaction(@Path('id') int id);

  /// Category Endpoints

  @GET('/categories/')
  Future<BaseResponse<List<CategoryResponse>>> getCategories();

  @POST('/categories/')
  Future<BaseResponse> createCategory(@Body() CategoryRequest request);

  @PUT('/categories/{id}')
  Future<BaseResponse> updateCategory(@Path('id') int id, @Body() CategoryRequest request);

  @DELETE('/categories/{id}')
  Future<void> deleteCategory(@Path('id') int id);

  /// Budget Endpoints

  @GET('/budgets/')
  Future<BasePaginationResponse<BudgetResponse>> getBudgets(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('sort_by') String sortBy,
    @Query('sort_order') String sortOrder,
    @Query('status') int? status,
  );

  @POST('/budgets/')
  Future<BaseResponse> createBudget(@Body() BudgetRequest request);

  @PUT('/budgets/{id}')
  Future<BaseResponse> updateBudget(@Path('id') int id, @Body() BudgetRequest request);

  @DELETE('/budgets/{id}')
  Future<void> deleteBudget(@Path('id') int id);

  /// Profile Endpoints

  @GET('/users/')
  Future<BaseResponse<ProfileResponse>> getProfile();

  @PUT('/users/')
  Future<BaseResponse> updateProfile(@Body() UpdateProfileRequest request);

  @DELETE('/users/')
  Future<void> deleteAccount();

  @POST('/users/change-password')
  Future<BaseResponse> changePassword(@Body() ChangePasswordRequest request);

  /// Dashboard Endpoints

  @GET('/dashboard/')
  Future<BaseResponse<DashboardResponse>> getDashboard({
    @Query('month') String? month,
    @Query('transaction_limit') int? transactionLimit,
    @Query('expense_limit') int? expenseLimit,
    @Query('budget_limit') int? budgetLimit,
  });
}
