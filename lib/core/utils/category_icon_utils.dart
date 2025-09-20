import 'package:flutter/material.dart';

/// Utility class for getting consistent category icons across the app
class CategoryIconUtils {
  /// Get the appropriate icon for a given category name
  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      // Food & Dining
      case 'food':
      case 'food & dining':
      case 'fooddining':
      case 'makan':
      case 'makanan':
        return Icons.restaurant;

      // Transportation
      case 'transport':
      case 'transportation':
      case 'transportasi':
        return Icons.directions_car;

      // Entertainment
      case 'entertainment':
      case 'hiburan':
        return Icons.movie;

      // Income & Salary
      case 'income':
      case 'salary':
      case 'gaji':
      case 'pendapatan':
        return Icons.attach_money;

      // Shopping
      case 'shopping':
      case 'belanja':
        return Icons.shopping_bag;

      // Healthcare
      case 'healthcare':
      case 'health':
      case 'kesehatan':
        return Icons.local_hospital;

      // Education
      case 'education':
      case 'pendidikan':
        return Icons.school;

      // Bills & Utilities
      case 'bills':
      case 'bills & utilities':
      case 'utilities':
      case 'tagihan':
        return Icons.receipt_long;

      // Coffee & Beverages
      case 'coffee':
      case 'kopi':
      case 'beverages':
      case 'minuman':
        return Icons.local_cafe;

      // Housing & Rent
      case 'housing':
      case 'rent':
      case 'rumah':
      case 'sewa':
        return Icons.home;

      // Fuel & Gas
      case 'fuel':
      case 'gas':
      case 'bensin':
        return Icons.local_gas_station;

      // Technology
      case 'technology':
      case 'tech':
      case 'teknologi':
        return Icons.devices;

      // Clothing
      case 'clothing':
      case 'fashion':
      case 'pakaian':
        return Icons.checkroom;

      // Personal Care
      case 'personal care':
      case 'beauty':
      case 'perawatan':
        return Icons.face;

      // Travel
      case 'travel':
      case 'vacation':
      case 'perjalanan':
        return Icons.flight;

      // Gifts
      case 'gifts':
      case 'hadiah':
        return Icons.card_giftcard;

      // Default icon for unknown categories
      default:
        return Icons.category;
    }
  }

  /// Get the appropriate color for expense/income transactions
  static Color getCategoryColor(String transactionType, {required bool isDarkMode}) {
    final isExpense = transactionType.toLowerCase() == 'expense';

    if (isExpense) {
      return const Color(0xFFE74C3C); // Error color for expenses
    } else {
      return const Color(0xFF27AE60); // Success color for income
    }
  }

  /// Get the appropriate background color for expense/income transactions
  static Color getCategoryBackgroundColor(String transactionType, {required bool isDarkMode}) {
    final isExpense = transactionType.toLowerCase() == 'expense';

    if (isExpense) {
      return isDarkMode
        ? const Color(0xFFE74C3C).withValues(alpha: 0.2)
        : const Color(0xFFE74C3C).withValues(alpha: 0.1);
    } else {
      return isDarkMode
        ? const Color(0xFF27AE60).withValues(alpha: 0.2)
        : const Color(0xFF27AE60).withValues(alpha: 0.1);
    }
  }

  /// Get border color for category containers
  static Color getCategoryBorderColor(String transactionType) {
    final isExpense = transactionType.toLowerCase() == 'expense';

    if (isExpense) {
      return const Color(0xFFE74C3C).withValues(alpha: 0.3);
    } else {
      return const Color(0xFF27AE60).withValues(alpha: 0.3);
    }
  }
}