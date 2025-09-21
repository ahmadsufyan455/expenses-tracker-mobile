import 'package:flutter/material.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';

/// Budget status enum for tracking budget lifecycle
enum BudgetStatus {
  upcoming('upcoming'),
  active('active'),
  expired('expired');

  const BudgetStatus(this.value);
  final String value;

  /// Create BudgetStatus from string value
  static BudgetStatus fromString(String value) {
    return BudgetStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => BudgetStatus.active,
    );
  }
}

/// Extension methods for BudgetStatus
extension BudgetStatusExtension on BudgetStatus {
  /// Get localized display name
  String getDisplayName(BuildContext context) {
    switch (this) {
      case BudgetStatus.upcoming:
        return context.l10n.budgetStatusUpcoming;
      case BudgetStatus.active:
        return context.l10n.budgetStatusActive;
      case BudgetStatus.expired:
        return context.l10n.budgetStatusExpired;
    }
  }

  /// Get color for budget status
  Color get color {
    switch (this) {
      case BudgetStatus.upcoming:
        return Colors.blue;
      case BudgetStatus.active:
        return Colors.green;
      case BudgetStatus.expired:
        return Colors.red;
    }
  }

  /// Get icon for budget status
  IconData get icon {
    switch (this) {
      case BudgetStatus.upcoming:
        return Icons.schedule;
      case BudgetStatus.active:
        return Icons.check_circle;
      case BudgetStatus.expired:
        return Icons.access_time;
    }
  }
}

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