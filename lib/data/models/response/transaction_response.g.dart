// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      type: json['type'] as String,
      paymentMethod: json['payment_method'] as String,
      categoryName: json['category_name'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
