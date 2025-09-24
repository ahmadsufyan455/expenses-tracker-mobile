import 'package:equatable/equatable.dart';
import 'package:expense_tracker_mobile/core/enums/transaction_enums.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/domain/dto/transaction_dto.dart';
import 'package:expense_tracker_mobile/domain/usecases/create_transaction_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/delete_transaction_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/get_category_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/get_transaction_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/update_transaction_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CreateTransactionUsecase _createTransactionUsecase;
  final GetCategoryUsecase _getCategoryUsecase;
  final GetTransactionUsecase _getTransactionUsecase;
  final DeleteTransactionUsecase _deleteTransactionUsecase;
  final UpdateTransactionUsecase _updateTransactionUsecase;

  var stateData = TransactionStateData();

  int page = 1;
  int perPage = 10;
  String sortBy = 'created_at';
  String sortOrder = 'desc';

  TransactionBloc(
    this._createTransactionUsecase,
    this._getCategoryUsecase,
    this._getTransactionUsecase,
    this._deleteTransactionUsecase,
    this._updateTransactionUsecase,
  ) : super(TransactionInitial()) {
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<GetCategoryEvent>(_onGetCategory);
    on<GetTransactionEvent>(_onGetTransaction);
    on<GetMoreTransactionEvent>(_onGetMoreTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
  }

  Future<void> _onGetCategory(GetCategoryEvent event, Emitter<TransactionState> emit) async {
    final result = await _getCategoryUsecase.call();
    result.fold(
      (failure) {
        emit(GetCategoryFailure(failure: failure, data: stateData));
      },
      (categories) {
        stateData = stateData.copyWith(categories: categories);
        emit(GetCategorySuccess(data: stateData));
      },
    );
  }

  Future<void> _onCreateTransaction(CreateTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(CreateTransactionLoading(data: stateData));
    final request = NewTransactionRequest(
      amount: event.amount,
      type: TransactionType.fromString(event.type),
      paymentMethod: PaymentMethod.fromString(event.paymentMethod),
      categoryId: event.categoryId,
      description: event.description,
      date: event.date,
    );
    final result = await _createTransactionUsecase.call(request);
    result.fold(
      (failure) {
        emit(CreateTransactionFailure(failure: failure, data: stateData));
      },
      (message) {
        stateData = stateData.copyWith(message: message);
        emit(CreateTransactionSuccess(data: stateData));
      },
    );
  }

  Future<void> _onGetTransaction(GetTransactionEvent event, Emitter<TransactionState> emit) async {
    // Reset pagination when refreshing
    page = 1;
    emit(GetTransactionLoading(data: stateData));
    final result = await _getTransactionUsecase.call(page, perPage, sortBy, sortOrder);
    result.fold(
      (failure) {
        emit(GetTransactionFailure(failure: failure, data: stateData));
      },
      (transactions) {
        stateData = stateData.copyWith(
          transactions: transactions,
          hasMoreData: transactions.length == perPage, // If we got less than perPage, no more data
          isLoadingMore: false,
        );
        emit(GetTransactionSuccess(data: stateData));
      },
    );
  }

  Future<void> _onGetMoreTransaction(GetMoreTransactionEvent event, Emitter<TransactionState> emit) async {
    // Don't load more if already loading or no more data
    if (stateData.isLoadingMore || !stateData.hasMoreData) return;

    // Set loading more state
    stateData = stateData.copyWith(isLoadingMore: true);
    emit(GetTransactionSuccess(data: stateData));

    page++;
    final result = await _getTransactionUsecase.call(page, perPage, sortBy, sortOrder);
    result.fold(
      (failure) {
        // Reset page on failure and stop loading
        page--;
        stateData = stateData.copyWith(isLoadingMore: false);
        emit(GetTransactionFailure(failure: failure, data: stateData));
      },
      (transactions) {
        stateData = stateData.copyWith(
          transactions: [...stateData.transactions, ...transactions],
          hasMoreData: transactions.length == perPage, // If we got less than perPage, no more data
          isLoadingMore: false,
        );
        emit(GetTransactionSuccess(data: stateData));
      },
    );
  }

  Future<void> _onDeleteTransaction(DeleteTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(DeleteTransactionLoading(data: stateData));
    final result = await _deleteTransactionUsecase.call(event.id);
    result.fold(
      (failure) {
        emit(DeleteTransactionFailure(failure: failure, data: stateData));
      },
      (_) {
        stateData = stateData.copyWith(message: 'Transaction deleted successfully');
        emit(DeleteTransactionSuccess(data: stateData));
      },
    );
  }

  Future<void> _onUpdateTransaction(UpdateTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(UpdateTransactionLoading(data: stateData));
    final request = NewTransactionRequest(
      amount: event.amount,
      type: TransactionType.fromString(event.type),
      paymentMethod: PaymentMethod.fromString(event.paymentMethod),
      categoryId: event.categoryId,
      description: event.description,
      date: event.date,
    );
    final result = await _updateTransactionUsecase.call(event.id, request);
    result.fold(
      (failure) {
        emit(UpdateTransactionFailure(failure: failure, data: stateData));
      },
      (message) {
        stateData = stateData.copyWith(message: message);
        emit(UpdateTransactionSuccess(data: stateData));
      },
    );
  }
}
