import 'package:flutter/material.dart';

/// Transaction type enum for expense and income
enum TransactionType {
  expense('expense'),
  income('income');

  const TransactionType(this.value);
  final String value;

  /// Create TransactionType from string value
  static TransactionType fromString(String value) {
    return TransactionType.values.firstWhere((type) => type.value == value, orElse: () => TransactionType.expense);
  }
}

/// Payment method enum for different payment options
enum PaymentMethod {
  cash('cash'),
  creditCard('credit_card'),
  bankTransfer('bank_transfer'),
  digitalWallet('digital_wallet');

  const PaymentMethod(this.value);
  final String value;

  /// Create PaymentMethod from string value
  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere((method) => method.value == value, orElse: () => PaymentMethod.cash);
  }
}

/// Extension methods for TransactionType
extension TransactionTypeExtension on TransactionType {
  /// Get display color for transaction type
  Color get color {
    switch (this) {
      case TransactionType.expense:
        return Colors.red.shade700;
      case TransactionType.income:
        return Colors.green.shade700;
    }
  }

  /// Get background color for transaction type
  Color get backgroundColor {
    switch (this) {
      case TransactionType.expense:
        return Colors.red.shade100;
      case TransactionType.income:
        return Colors.green.shade100;
    }
  }

  /// Get icon for transaction type
  IconData get icon {
    switch (this) {
      case TransactionType.expense:
        return Icons.trending_down_rounded;
      case TransactionType.income:
        return Icons.trending_up_rounded;
    }
  }

  /// Get localized display name
  String getDisplayName(BuildContext context) {
    switch (this) {
      case TransactionType.expense:
        return 'Expense';
      case TransactionType.income:
        return 'Income';
    }
  }
}

/// Extension methods for PaymentMethod
extension PaymentMethodExtension on PaymentMethod {
  IconData get icon {
    switch (this) {
      case PaymentMethod.cash:
        return Icons.payments_outlined;
      case PaymentMethod.creditCard:
        return Icons.credit_card_outlined;
      case PaymentMethod.bankTransfer:
        return Icons.account_balance_outlined;
      case PaymentMethod.digitalWallet:
        return Icons.wallet_outlined;
    }
  }

  /// Get localized display name
  String getDisplayName(BuildContext context) {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.digitalWallet:
        return 'Digital Wallet';
    }
  }
}
