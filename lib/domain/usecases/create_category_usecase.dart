import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/category_request.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateCategoryUseCase {
  final MainRepository _mainRepository;

  CreateCategoryUseCase(this._mainRepository);

  Future<Either<Failure, String>> call(CategoryRequest request) async {
    return await _mainRepository.createCategory(request);
  }
}
