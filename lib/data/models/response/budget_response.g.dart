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
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      predictionEnabled: json['prediction_enabled'] as bool,
      predictionType: json['prediction_type'] as String?,
      predictionDaysCount: (json['prediction_days_count'] as num?)?.toInt(),
      prediction: json['prediction'] == null
          ? null
          : PredictionResponse.fromJson(
              json['prediction'] as Map<String, dynamic>,
            ),
    );
