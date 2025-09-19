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
  static String formatFilterToDisplayName(BuildContext context, String filter) {
    try {
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
}
