import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/change_password_request.dart';
import 'package:expense_tracker_mobile/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUsecase {
  final AuthRepository _authRepository;

  ChangePasswordUsecase(this._authRepository);

  Future<Either<Failure, String>> call(ChangePasswordRequest request) async {
    return await _authRepository.changePassword(request);
  }
}