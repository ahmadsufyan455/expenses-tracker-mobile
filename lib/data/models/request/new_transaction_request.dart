import 'package:expense_tracker_mobile/core/enums/transaction_enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_transaction_request.g.dart';

@JsonSerializable()
class NewTransactionRequest {
  @JsonKey(name: 'amount')
  final int amount;
  @JsonKey(name: 'type', fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson)
  final TransactionType type;
  @JsonKey(name: 'payment_method', fromJson: _paymentMethodFromJson, toJson: _paymentMethodToJson)
  final PaymentMethod paymentMethod;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'date')
  final String date;

  NewTransactionRequest({
    required this.amount,
    required this.type,
    required this.paymentMethod,
    required this.categoryId,
    required this.description,
    required this.date,
  });

  // JSON serialization helpers
  static TransactionType _transactionTypeFromJson(String json) => TransactionType.fromString(json);
  static String _transactionTypeToJson(TransactionType type) => type.value;

  static PaymentMethod _paymentMethodFromJson(String json) => PaymentMethod.fromString(json);
  static String _paymentMethodToJson(PaymentMethod method) => method.value;

  factory NewTransactionRequest.fromJson(Map<String, dynamic> json) => _$NewTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NewTransactionRequestToJson(this);
}
