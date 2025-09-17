import 'package:expense_tracker_mobile/data/models/response/transaction_response.dart';

class TransactionDto {
  final int id;
  final int amount;
  final String description;
  final String createdAt;
  final String updatedAt;
  final TransactionCategoryDto category;
  final String paymentMethod;
  final String type;

  TransactionDto({
    required this.id,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.paymentMethod,
    required this.type,
  });

  factory TransactionDto.fromResponse(TransactionResponse response) {
    return TransactionDto(
      id: response.id,
      amount: response.amount,
      description: response.description,
      createdAt: response.createdAt,
      updatedAt: response.updatedAt,
      category: TransactionCategoryDto(id: response.category?.id ?? 0, name: response.category?.name ?? ''),
      paymentMethod: response.paymentMethod,
      type: response.type,
    );
  }

  static List<TransactionDto> fromResponseList(List<TransactionResponse> response) {
    return response.map((transaction) => TransactionDto.fromResponse(transaction)).toList();
  }
}

class TransactionCategoryDto {
  final int id;
  final String name;

  TransactionCategoryDto({required this.id, required this.name});
}
