import 'package:json_annotation/json_annotation.dart';

part 'transaction_response.g.dart';

@JsonSerializable(createToJson: false)
class TransactionResponse {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'amount')
  final int amount;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @JsonKey(name: 'category')
  final TransactionCategoryResponse? category;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  TransactionResponse({
    required this.id,
    required this.amount,
    required this.type,
    required this.paymentMethod,
    this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => _$TransactionResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TransactionCategoryResponse {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;

  TransactionCategoryResponse({required this.id, required this.name});

  factory TransactionCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionCategoryResponseFromJson(json);
}
