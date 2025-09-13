import 'package:flutter/material.dart';

import '../../generated/l10n/app_localizations.dart';

/// Utility class for localization helpers
class LocalizationUtils {
  LocalizationUtils._();

  /// Get AppLocalizations from context
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  /// Check if current locale is Indonesian
  static bool isIndonesian(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'id';
  }

  /// Check if current locale is English
  static bool isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }

  /// Get current locale
  static Locale getCurrentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  /// Get current language code
  static String getCurrentLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  /// Format currency based on locale
  static String formatCurrency(BuildContext context, double amount) {
    if (isIndonesian(context)) {
      return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
    } else {
      return '\$${amount.toStringAsFixed(2)}';
    }
  }

  /// Format number based on locale
  static String formatNumber(BuildContext context, double number) {
    if (isIndonesian(context)) {
      return number
          .toStringAsFixed(0)
          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
    } else {
      return number
          .toStringAsFixed(2)
          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    }
  }

  /// Get localized date format pattern
  static String getDateFormatPattern(BuildContext context) {
    if (isIndonesian(context)) {
      return 'dd/MM/yyyy'; // Indonesian format
    } else {
      return 'MM/dd/yyyy'; // US format
    }
  }

  /// Get localized short date format pattern
  static String getShortDateFormatPattern(BuildContext context) {
    if (isIndonesian(context)) {
      return 'dd MMM yyyy'; // 01 Jan 2024
    } else {
      return 'MMM dd, yyyy'; // Jan 01, 2024
    }
  }

  /// Get localized month names
  static List<String> getMonthNames(BuildContext context) {
    if (isIndonesian(context)) {
      return [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember',
      ];
    } else {
      return [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
    }
  }

  /// Get localized day names
  static List<String> getDayNames(BuildContext context) {
    if (isIndonesian(context)) {
      return ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    } else {
      return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    }
  }

  /// Get localized short day names
  static List<String> getShortDayNames(BuildContext context) {
    if (isIndonesian(context)) {
      return ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    } else {
      return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    }
  }

  /// Get relative date string (today, yesterday, X days ago, or full date)
  static String getRelativeDate(BuildContext context, String dateString) {
    try {
      final DateTime transactionDate = DateTime.parse(dateString);
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime transactionDay = DateTime(transactionDate.year, transactionDate.month, transactionDate.day);

      final int daysDifference = today.difference(transactionDay).inDays;

      final AppLocalizations l10n = of(context);

      if (daysDifference == 0) {
        return l10n.today;
      } else if (daysDifference == 1) {
        return l10n.yesterday;
      } else if (daysDifference <= 3) {
        return l10n.daysAgo(daysDifference);
      } else {
        // Format as "23 September 2025" for dates older than 3 days
        final monthNames = getMonthNames(context);
        final monthName = monthNames[transactionDate.month - 1];
        return '${transactionDate.day} $monthName ${transactionDate.year}';
      }
    } catch (e) {
      return dateString;
    }
  }

  /// Get section name for transaction grouping
  static String getTransactionSection(BuildContext context, String dateString) {
    try {
      final DateTime transactionDate = DateTime.parse(dateString);
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime transactionDay = DateTime(transactionDate.year, transactionDate.month, transactionDate.day);

      final int daysDifference = today.difference(transactionDay).inDays;

      final AppLocalizations l10n = of(context);

      if (daysDifference == 0) {
        return l10n.today;
      } else if (daysDifference == 1) {
        return l10n.yesterday;
      } else {
        return isIndonesian(context) ? 'Sebelumnya' : 'Past';
      }
    } catch (e) {
      return isIndonesian(context) ? 'Sebelumnya' : 'Past';
    }
  }
}
