import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAccountUsecase {
  final AuthRepository _authRepository;

  DeleteAccountUsecase(this._authRepository);

  Future<Either<Failure, void>> call() async {
    return await _authRepository.deleteAccount();
  }
}