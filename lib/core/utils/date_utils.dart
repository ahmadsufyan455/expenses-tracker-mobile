import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:flutter/material.dart';

/// Utility class for date-related operations
class AppDateUtils {
  AppDateUtils._();

  /// Get current month in YYYY-MM format
  static String getCurrentMonthFilter() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }

  /// Convert YYYY-MM format to localized month name with year
  /// Also handles custom period filters (YYYY-MM-DD:YYYY-MM-DD)
  static String formatFilterToDisplayName(BuildContext context, String filter) {
    try {
      // Check if it's a custom period filter
      if (isCustomPeriodFilter(filter)) {
        return formatCustomPeriodToDisplayName(context, filter);
      }

      final parts = filter.split('-');
      if (parts.length != 2) return filter;

      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);

      if (month < 1 || month > 12) return filter;

      final monthNames = LocalizationUtils.getMonthNames(context);
      return '${monthNames[month - 1]} $year';
    } catch (e) {
      return filter;
    }
  }

  /// Convert localized month name with year back to YYYY-MM format
  static String formatDisplayNameToFilter(BuildContext context, String displayName) {
    try {
      final monthNames = LocalizationUtils.getMonthNames(context);

      // Split by space to get month and year
      final parts = displayName.split(' ');
      if (parts.length != 2) return displayName;

      final monthName = parts[0];
      final year = int.parse(parts[1]);

      final monthIndex = monthNames.indexOf(monthName);
      if (monthIndex == -1) return displayName;

      final month = monthIndex + 1;
      return '$year-${month.toString().padLeft(2, '0')}';
    } catch (e) {
      return displayName;
    }
  }

  /// Generate list of month filters for the current year only
  static List<String> getAvailableMonthFilters() {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    final List<String> filters = [];

    // Add months from current year (up to current month)
    for (int month = 1; month <= currentMonth; month++) {
      filters.add('$currentYear-${month.toString().padLeft(2, '0')}');
    }

    // Sort in descending order (most recent first)
    filters.sort((a, b) => b.compareTo(a));

    return filters;
  }

  /// Generate display names for available month filters
  static List<String> getAvailableMonthDisplayNames(BuildContext context) {
    final filters = getAvailableMonthFilters();
    return filters.map((filter) => formatFilterToDisplayName(context, filter)).toList();
  }

  /// Get the display name for current month
  static String getCurrentMonthDisplayName(BuildContext context) {
    return formatFilterToDisplayName(context, getCurrentMonthFilter());
  }

  /// Format custom period filter to string (YYYY-MM-DD:YYYY-MM-DD)
  static String formatCustomPeriodFilter(DateTime startDate, DateTime endDate) {
    final start =
        '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final end = '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
    return '$start:$end';
  }

  /// Check if filter is a custom period filter
  static bool isCustomPeriodFilter(String filter) {
    return filter.contains(':');
  }

  /// Parse custom period filter to get start and end dates
  static (DateTime?, DateTime?) parseCustomPeriodFilter(String filter) {
    try {
      if (!isCustomPeriodFilter(filter)) {
        return (null, null);
      }

      final parts = filter.split(':');
      if (parts.length != 2) {
        return (null, null);
      }

      final startParts = parts[0].split('-');
      final endParts = parts[1].split('-');

      if (startParts.length != 3 || endParts.length != 3) {
        return (null, null);
      }

      final startDate = DateTime(int.parse(startParts[0]), int.parse(startParts[1]), int.parse(startParts[2]));

      final endDate = DateTime(int.parse(endParts[0]), int.parse(endParts[1]), int.parse(endParts[2]));

      return (startDate, endDate);
    } catch (e) {
      return (null, null);
    }
  }

  /// Format custom period filter to display name
  static String formatCustomPeriodToDisplayName(BuildContext context, String filter) {
    final (startDate, endDate) = parseCustomPeriodFilter(filter);

    if (startDate == null || endDate == null) {
      return filter;
    }

    final start =
        '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final end = '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';

    return '$start - $end';
  }

  /// Convert filter string to start and end date strings (YYYY-MM-DD format)
  /// Returns (startDate, endDate) tuple
  static (String?, String?) getDateRangeFromFilter(String filter) {
    // Check if it's a custom period filter (YYYY-MM-DD:YYYY-MM-DD)
    if (isCustomPeriodFilter(filter)) {
      final (startDate, endDate) = parseCustomPeriodFilter(filter);
      if (startDate != null && endDate != null) {
        final start =
            '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
        final end =
            '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
        return (start, end);
      }
      return (null, null);
    }

    // Monthly filter (YYYY-MM)
    try {
      final parts = filter.split('-');
      if (parts.length != 2) return (null, null);

      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);

      if (month < 1 || month > 12) return (null, null);

      // First day of the month
      final startDate = DateTime(year, month, 1);
      // Last day of the month
      final endDate = DateTime(year, month + 1, 0);

      final start =
          '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
      final end =
          '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';

      return (start, end);
    } catch (e) {
      return (null, null);
    }
  }
}
