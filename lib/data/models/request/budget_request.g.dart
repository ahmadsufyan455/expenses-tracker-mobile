// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetRequest _$BudgetRequestFromJson(Map<String, dynamic> json) =>
    BudgetRequest(
      categoryId: (json['category_id'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      month: json['month'] as String,
    );

Map<String, dynamic> _$BudgetRequestToJson(BudgetRequest instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'amount': instance.amount,
      'month': instance.month,
    };
