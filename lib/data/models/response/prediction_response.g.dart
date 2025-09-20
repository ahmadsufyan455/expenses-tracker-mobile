// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionResponse _$PredictionResponseFromJson(Map<String, dynamic> json) =>
    PredictionResponse(
      dailyAllowance: (json['daily_allowance'] as num).toInt(),
      remainingBudget: (json['remaining_budget'] as num).toInt(),
      daysRemaining: (json['days_remaining'] as num).toInt(),
      predictionType: json['prediction_type'] as String,
    );
