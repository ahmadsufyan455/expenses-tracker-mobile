import 'package:expense_tracker_mobile/core/errors/error_handler.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/datasources/remote/api_service.dart';
import 'package:expense_tracker_mobile/data/models/request/change_password_request.dart';
import 'package:expense_tracker_mobile/data/models/request/login_request.dart';
import 'package:expense_tracker_mobile/data/models/request/register_request.dart';
import 'package:expense_tracker_mobile/data/models/request/update_profile_request.dart';
import 'package:expense_tracker_mobile/data/models/response/login_response.dart';
import 'package:expense_tracker_mobile/domain/dto/profile_dto.dart';
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
  Future<Either<Failure, String>> register(RegisterRequest request) async {
    try {
      final response = await _apiService.register(request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, ProfileDto>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      final profile = ProfileDto.fromResponse(response.data!);
      return Right(profile);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfile(UpdateProfileRequest request) async {
    try {
      final response = await _apiService.updateProfile(request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await _apiService.deleteAccount();
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(ChangePasswordRequest request) async {
    try {
      final response = await _apiService.changePassword(request);
      return Right(response.message);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}
