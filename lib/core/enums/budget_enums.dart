import 'package:flutter/material.dart';

/// Prediction type enum for budget prediction options
enum PredictionType {
  daily('daily'),
  weekends('weekends'),
  weekdays('weekdays'),
  custom('custom');

  const PredictionType(this.value);
  final String value;

  /// Create PredictionType from string value
  static PredictionType fromString(String value) {
    return PredictionType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => PredictionType.daily,
    );
  }
}

/// Extension methods for PredictionType
extension PredictionTypeExtension on PredictionType {
  /// Get localized display name
  String getDisplayName(BuildContext context) {
    switch (this) {
      case PredictionType.daily:
        return 'Daily';
      case PredictionType.weekends:
        return 'Weekends';
      case PredictionType.weekdays:
        return 'Weekdays';
      case PredictionType.custom:
        return 'Custom';
    }
  }

  /// Get icon for prediction type
  IconData get icon {
    switch (this) {
      case PredictionType.daily:
        return Icons.calendar_today;
      case PredictionType.weekends:
        return Icons.weekend;
      case PredictionType.weekdays:
        return Icons.work_outline;
      case PredictionType.custom:
        return Icons.tune;
    }
  }
}