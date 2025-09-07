import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class ValidationUtils {
  ValidationUtils._();

  /// Validates email format
  static String? validateEmail(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return context != null ? context.l10n.emailRequired : 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return context != null
          ? context.l10n.emailInvalid
          : 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates password with basic requirements (for login)
  static String? validatePassword(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return context != null
          ? context.l10n.passwordRequired
          : 'Password is required';
    }
    if (value.length < 8) {
      return context != null
          ? context.l10n.passwordTooShort(8)
          : 'Password must be at least 8 characters';
    }
    return null;
  }

  /// Validates name fields (first name, last name)
  static String? validateName(
    String? value,
    String fieldName, [
    BuildContext? context,
  ]) {
    if (value == null || value.isEmpty) {
      return context != null
          ? context.l10n.fieldRequired(fieldName)
          : '$fieldName is required';
    }
    if (value.length < 2) {
      return context != null
          ? context.l10n.fieldTooShort(fieldName, 2)
          : '$fieldName must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return context != null
          ? context.l10n.nameLettersOnly(fieldName)
          : '$fieldName can only contain letters';
    }
    return null;
  }

  /// Validates required fields
  static String? validateRequired(
    String? value,
    String fieldName, [
    BuildContext? context,
  ]) {
    if (value == null || value.isEmpty) {
      return context != null
          ? context.l10n.fieldRequired(fieldName)
          : '$fieldName is required';
    }
    return null;
  }

  /// Validates positive number (useful for expense amounts)
  static String? validatePositiveNumber(
    String? value,
    String fieldName, [
    BuildContext? context,
  ]) {
    if (value == null || value.isEmpty) {
      return context != null
          ? context.l10n.numberRequired(fieldName)
          : '$fieldName is required';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return context != null
          ? context.l10n.numberInvalid(fieldName)
          : '$fieldName must be a valid number';
    }
    if (number <= 0) {
      return context != null
          ? context.l10n.numberMustBePositive(fieldName)
          : '$fieldName must be greater than 0';
    }
    return null;
  }
}
