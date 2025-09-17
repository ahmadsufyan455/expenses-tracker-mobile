import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/category_request.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCategoryUsecase {
  final MainRepository _mainRepository;

  UpdateCategoryUsecase(this._mainRepository);

  Future<Either<Failure, String>> call(int id, CategoryRequest request) async {
    return _mainRepository.updateCategory(id, request);
  }
}
