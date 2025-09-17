import 'package:equatable/equatable.dart';
import 'package:expense_tracker_mobile/data/models/request/category_request.dart';
import 'package:expense_tracker_mobile/domain/usecases/create_category_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/get_category_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../domain/dto/category_dto.dart';

part 'category_event.dart';
part 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUsecase _getCategoryUsecase;
  final CreateCategoryUseCase _createCategoryUseCase;

  CategoryBloc(this._getCategoryUsecase, this._createCategoryUseCase) : super(CategoryInitial()) {
    on<GetCategoryEvent>(_onGetCategory);
    on<CreateCategoryEvent>(_onCreateCategory);
  }

  Future<void> _onGetCategory(GetCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final result = await _getCategoryUsecase.call();
    result.fold(
      (failure) => emit(CategoryError(failure: failure)),
      (categories) => emit(CategoryLoaded(categories: categories)),
    );
  }

  Future<void> _onCreateCategory(CreateCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final request = CategoryRequest(name: event.name);
    final result = await _createCategoryUseCase.call(request);
    result.fold(
      (failure) => emit(CategoryError(failure: failure)),
      (message) => emit(CreateCategorySuccess(message: message)),
    );
  }
}
