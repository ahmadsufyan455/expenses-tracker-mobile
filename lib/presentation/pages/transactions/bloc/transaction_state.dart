part of 'transaction_bloc.dart';

class TransactionStateData extends Equatable {
  final List<CategoryDto> categories;
  final String message;

  const TransactionStateData({this.categories = const [], this.message = ''});

  @override
  List<Object> get props => [categories, message];

  TransactionStateData copyWith({List<CategoryDto>? categories, String? message}) {
    return TransactionStateData(categories: categories ?? this.categories, message: message ?? this.message);
  }
}

sealed class TransactionState extends Equatable {
  final TransactionStateData data;
  const TransactionState({required this.data});

  @override
  List<Object> get props => [data];
}

final class TransactionInitial extends TransactionState {
  TransactionInitial() : super(data: TransactionStateData());
}

/// create transaction
final class CreateTransactionLoading extends TransactionState {
  const CreateTransactionLoading({required super.data});
}

final class CreateTransactionSuccess extends TransactionState {
  const CreateTransactionSuccess({required super.data});
}

final class CreateTransactionFailure extends TransactionState {
  final Failure failure;

  const CreateTransactionFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}

/// get category
final class GetCategorySuccess extends TransactionState {
  const GetCategorySuccess({required super.data});
}

final class GetCategoryFailure extends TransactionState {
  final Failure failure;

  const GetCategoryFailure({required this.failure, required super.data});

  @override
  List<Object> get props => [failure];
}
