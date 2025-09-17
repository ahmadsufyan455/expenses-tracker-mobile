import "package:dio/dio.dart";
import 'package:expense_tracker_mobile/data/models/request/category_request.dart';
import 'package:expense_tracker_mobile/data/models/request/login_request.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/data/models/request/register_request.dart';
import 'package:expense_tracker_mobile/data/models/response/base_pagination_response.dart';
import 'package:expense_tracker_mobile/data/models/response/base_response.dart';
import 'package:expense_tracker_mobile/data/models/response/category_response.dart';
import 'package:expense_tracker_mobile/data/models/response/login_response.dart';
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

  @GET('/transactions')
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

  @GET('/categories')
  Future<BaseResponse<List<CategoryResponse>>> getCategories();

  @POST('/categories/')
  Future<BaseResponse> createCategory(@Body() CategoryRequest request);
}
