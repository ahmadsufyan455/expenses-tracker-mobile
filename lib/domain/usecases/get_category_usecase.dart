import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/domain/repositories/main_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryUsecase {
  final MainRepository _mainRepository;

  GetCategoryUsecase(this._mainRepository);

  Future<Either<Failure, List<CategoryDto>>> call() async {
    return await _mainRepository.getCategories().then((value) {
      return value.map((response) => CategoryDto.fromCategoryResponseList(response));
    });
  }
}
