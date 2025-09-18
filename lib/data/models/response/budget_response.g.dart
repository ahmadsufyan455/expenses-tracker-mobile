// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetResponse _$BudgetResponseFromJson(Map<String, dynamic> json) =>
    BudgetResponse(
      id: (json['id'] as num).toInt(),
      categoryId: (json['category_id'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      month: json['month'] as String,
    );
