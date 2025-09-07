import 'package:expense_tracker_mobile/core/errors/error_handler.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/datasources/remote/api_service.dart';
import 'package:expense_tracker_mobile/data/models/request/login_request.dart';
import 'package:expense_tracker_mobile/data/models/request/register_request.dart';
import 'package:expense_tracker_mobile/data/models/response/base_response.dart';
import 'package:expense_tracker_mobile/data/models/response/login_response.dart';
import 'package:expense_tracker_mobile/data/models/response/user_response.dart';
import 'package:expense_tracker_mobile/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;
  AuthRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _apiService.login(request);
      return Right(response.data!);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<UserResponse>>> register(
    RegisterRequest request,
  ) async {
    try {
      final response = await _apiService.register(request);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}
