import 'package:equatable/equatable.dart';
import 'package:expense_tracker_mobile/core/enums/transaction_enums.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:expense_tracker_mobile/data/models/request/new_transaction_request.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/domain/usecases/create_transaction_usecase.dart';
import 'package:expense_tracker_mobile/domain/usecases/get_category_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CreateTransactionUsecase _createTransactionUsecase;
  final GetCategoryUsecase _getCategoryUsecase;

  var stateData = TransactionStateData();

  TransactionBloc(this._createTransactionUsecase, this._getCategoryUsecase) : super(TransactionInitial()) {
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<GetCategoryEvent>(_onGetCategory);
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
}
