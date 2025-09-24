// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTransactionRequest _$NewTransactionRequestFromJson(
  Map<String, dynamic> json,
) => NewTransactionRequest(
  amount: (json['amount'] as num).toInt(),
  type: NewTransactionRequest._transactionTypeFromJson(json['type'] as String),
  paymentMethod: NewTransactionRequest._paymentMethodFromJson(
    json['payment_method'] as String,
  ),
  categoryId: (json['category_id'] as num).toInt(),
  description: json['description'] as String,
  date: json['transaction_date'] as String,
);

Map<String, dynamic> _$NewTransactionRequestToJson(
  NewTransactionRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'type': NewTransactionRequest._transactionTypeToJson(instance.type),
  'payment_method': NewTransactionRequest._paymentMethodToJson(
    instance.paymentMethod,
  ),
  'category_id': instance.categoryId,
  'description': instance.description,
  'transaction_date': instance.date,
};
