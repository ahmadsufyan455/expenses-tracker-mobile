import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberUtils {
  static final NumberFormat _formatter = NumberFormat('#,###', 'id_ID');

  /// Formats a number with Indonesian thousand separators (dots)
  /// Example: 10000 -> "10.000"
  static String formatWithThousandSeparator(int number) {
    String formatted = _formatter.format(number);
    // Replace commas with dots for Indonesian format
    return formatted.replaceAll(',', '.');
  }

  /// Removes thousand separators and converts to integer
  /// Example: "10.000" -> 10000
  static int parseFromFormattedString(String formattedString) {
    if (formattedString.isEmpty) return 0;

    // Remove all non-digit characters
    String digitsOnly = formattedString.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.isEmpty) return 0;

    return int.parse(digitsOnly);
  }

  /// Checks if a string contains only digits and thousand separators
  static bool isValidFormattedNumber(String value) {
    if (value.isEmpty) return false;

    // Remove dots and check if remaining characters are digits
    String digitsOnly = value.replaceAll('.', '');
    return RegExp(r'^\d+$').hasMatch(digitsOnly);
  }
}

class ThousandSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit characters
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.isEmpty) {
      return const TextEditingValue();
    }

    // Parse the number and format it with thousand separators
    int value = int.parse(digitsOnly);
    String formatted = NumberUtils.formatWithThousandSeparator(value);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}