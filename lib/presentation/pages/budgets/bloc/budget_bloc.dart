import 'package:equatable/equatable.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/budget_request.dart';
import 'package:expense_tracker_mobile/domain/dto/budget_dto.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/domain/usecases/create_budget_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/delete_budget_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/get_budget_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/get_category_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/update_budget_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'budget_event.dart';
part 'budget_state.dart';

@injectable
class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetBudgetUsecase _getBudgetUsecase;
  final CreateBudgetUsecase _createBudgetUsecase;
  final UpdateBudgetUsecase _updateBudgetUsecase;
  final DeleteBudgetUsecase _deleteBudgetUsecase;
  final GetCategoryUsecase _getCategoryUsecase;

  var stateData = BudgetStateData();

  BudgetBloc(
    this._getBudgetUsecase,
    this._createBudgetUsecase,
    this._updateBudgetUsecase,
    this._deleteBudgetUsecase,
    this._getCategoryUsecase,
  ) : super(BudgetInitial()) {
    on<GetBudgetEvent>(_onGetBudget);
    on<CreateBudgetEvent>(_onCreateBudget);
    on<UpdateBudgetEvent>(_onUpdateBudget);
    on<DeleteBudgetEvent>(_onDeleteBudget);
  }

  Future<void> _onGetBudget(GetBudgetEvent event, Emitter<BudgetState> emit) async {
    emit(GetBudgetLoading(data: stateData));

    // Get budgets and categories concurrently
    final budgetResult = await _getBudgetUsecase.call();
    final categoryResult = await _getCategoryUsecase.call();

    budgetResult.fold(
      (failure) {
        emit(GetBudgetFailure(failure: failure, data: stateData));
      },
      (budgets) {
        categoryResult.fold(
          (failure) {
            stateData = stateData.copyWith(budgets: budgets);
            emit(GetBudgetFailure(failure: failure, data: stateData));
          },
          (categories) {
            stateData = stateData.copyWith(budgets: budgets, categories: categories);
            emit(GetBudgetSuccess(data: stateData));
          },
        );
      },
    );
  }

  Future<void> _onCreateBudget(CreateBudgetEvent event, Emitter<BudgetState> emit) async {
    emit(CreateBudgetLoading(data: stateData));
    final request = BudgetRequest(
      categoryId: event.categoryId,
      amount: event.amount,
      month: event.month,
    );
    final result = await _createBudgetUsecase.call(request);
    result.fold(
      (failure) {
        emit(CreateBudgetFailure(failure: failure, data: stateData));
      },
      (message) {
        stateData = stateData.copyWith(message: message);
        emit(CreateBudgetSuccess(data: stateData));
      },
    );
  }

  Future<void> _onUpdateBudget(UpdateBudgetEvent event, Emitter<BudgetState> emit) async {
    emit(UpdateBudgetLoading(data: stateData));
    final request = BudgetRequest(
      categoryId: event.categoryId,
      amount: event.amount,
      month: event.month,
    );
    final result = await _updateBudgetUsecase.call(event.id, request);
    result.fold(
      (failure) {
        emit(UpdateBudgetFailure(failure: failure, data: stateData));
      },
      (message) {
        stateData = stateData.copyWith(message: message);
        emit(UpdateBudgetSuccess(data: stateData));
      },
    );
  }

  Future<void> _onDeleteBudget(DeleteBudgetEvent event, Emitter<BudgetState> emit) async {
    emit(DeleteBudgetLoading(data: stateData));
    final result = await _deleteBudgetUsecase.call(event.id);
    result.fold(
      (failure) {
        emit(DeleteBudgetFailure(failure: failure, data: stateData));
      },
      (message) {
        stateData = stateData.copyWith(message: message);
        emit(DeleteBudgetSuccess(data: stateData));
      },
    );
  }
}