import 'package:expense_tracker_mobile/data/models/response/transaction_response.dart';

class TransactionDto {
  final int id;
  final int amount;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String categoryName;
  final String paymentMethod;
  final String type;

  TransactionDto({
    required this.id,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
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
      categoryName: response.categoryName,
      paymentMethod: response.paymentMethod,
      type: response.type,
    );
  }

  static List<TransactionDto> fromResponseList(List<TransactionResponse> response) {
    return response.map((transaction) => TransactionDto.fromResponse(transaction)).toList();
  }
}
