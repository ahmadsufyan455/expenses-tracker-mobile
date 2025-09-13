part of 'transaction_bloc.dart';

class TransactionStateData extends Equatable {
  final List<CategoryDto> categories;
  final String message;
  final List<TransactionDto> transactions;
  final bool hasMoreData;
  final bool isLoadingMore;

  const TransactionStateData({
    this.categories = const [], 
    this.message = '', 
    this.transactions = const [],
    this.hasMoreData = true,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props => [categories, message, transactions, hasMoreData, isLoadingMore];

  TransactionStateData copyWith({
    List<CategoryDto>? categories, 
    String? message, 
    List<TransactionDto>? transactions,
    bool? hasMoreData,
    bool? isLoadingMore,
  }) {
    return TransactionStateData(
      categories: categories ?? this.categories,
      message: message ?? this.message,
      transactions: transactions ?? this.transactions,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
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

/// get transaction
final class GetTransactionLoading extends TransactionState {
  const GetTransactionLoading({required super.data});
}

final class GetTransactionSuccess extends TransactionState {
  const GetTransactionSuccess({required super.data});
}

final class GetTransactionFailure extends TransactionState {
  final Failure failure;
  const GetTransactionFailure({required this.failure, required super.data});
}
