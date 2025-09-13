part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class CreateTransactionEvent extends TransactionEvent {
  final int amount;
  final String type;
  final String paymentMethod;
  final int categoryId;
  final String description;

  const CreateTransactionEvent({
    required this.amount,
    required this.type,
    required this.paymentMethod,
    required this.categoryId,
    required this.description,
  });

  @override
  List<Object> get props => [amount, type, paymentMethod, categoryId, description];
}

class GetCategoryEvent extends TransactionEvent {
  const GetCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionEvent extends TransactionEvent {
  const GetTransactionEvent();

  @override
  List<Object> get props => [];
}

class GetMoreTransactionEvent extends TransactionEvent {
  const GetMoreTransactionEvent();

  @override
  List<Object> get props => [];
}

class DeleteTransactionEvent extends TransactionEvent {
  final int id;

  const DeleteTransactionEvent({required this.id});

  @override
  List<Object> get props => [id];
}
