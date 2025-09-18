import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/change_password_request.dart';
import 'package:expense_tracker_mobile/data/models/request/login_request.dart';
import 'package:expense_tracker_mobile/data/models/request/register_request.dart';
import 'package:expense_tracker_mobile/data/models/request/update_profile_request.dart';
import 'package:expense_tracker_mobile/data/models/response/login_response.dart';
import 'package:expense_tracker_mobile/domain/dto/profile_dto.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
  Future<Either<Failure, String>> register(RegisterRequest request);

  Future<Either<Failure, ProfileDto>> getProfile();
  Future<Either<Failure, String>> updateProfile(UpdateProfileRequest request);
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, String>> changePassword(ChangePasswordRequest request);
}
