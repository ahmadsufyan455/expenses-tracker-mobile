import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/register_request.dart';
import 'package:expense_tracker_mobile/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUsecase {
  final AuthRepository _authRepository;

  RegisterUsecase(this._authRepository);

  Future<Either<Failure, String>> call(RegisterRequest request) async {
    return await _authRepository.register(request);
  }
}
