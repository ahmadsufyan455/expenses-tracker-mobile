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
      predictionEnabled: json['prediction_enabled'] as bool,
      predictionType: json['prediction_type'] as String?,
      predictionDaysCount: (json['prediction_days_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BudgetRequestToJson(BudgetRequest instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'amount': instance.amount,
      'month': instance.month,
      'prediction_enabled': instance.predictionEnabled,
      'prediction_type': instance.predictionType,
      'prediction_days_count': instance.predictionDaysCount,
    };
