import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/enums/transaction_enums.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/transaction_dto.dart';
import 'package:flutter/material.dart';

class TransactionDetailBottomSheet extends StatelessWidget {
  const TransactionDetailBottomSheet({
    super.key,
    required this.transaction,
  });

  final TransactionDto transaction;

  static Future<void> show(BuildContext context, TransactionDto transaction) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionDetailBottomSheet(transaction: transaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionType = TransactionType.fromString(transaction.type);
    final paymentMethod = PaymentMethod.fromString(transaction.paymentMethod.toLowerCase().replaceAll(' ', '_'));
    final amount = transaction.amount.abs();
    final formattedAmount = LocalizationUtils.formatCurrency(context, amount.toDouble());
    
    // Format date as "23 September 2025"
    final DateTime transactionDate = DateTime.parse(transaction.createdAt);
    final monthNames = LocalizationUtils.getMonthNames(context);
    final monthName = monthNames[transactionDate.month - 1];
    final fullDate = '${transactionDate.day} $monthName ${transactionDate.year}';

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusL),
          topRight: Radius.circular(AppDimensions.radiusL),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceL),

            // Header with icon and amount
            Row(
              children: [
                Container(
                  width: AppDimensions.iconXL,
                  height: AppDimensions.iconXL,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: transactionType.backgroundColor,
                  ),
                  child: Icon(
                    transactionType.icon,
                    size: AppDimensions.iconM,
                    color: transactionType.color,
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.categoryName,
                        style: AppTextStyles.headlineSmall,
                      ),
                      const SizedBox(height: AppDimensions.spaceXS),
                      Text(
                        '${transactionType == TransactionType.income ? '+' : '-'}$formattedAmount',
                        style: transactionType == TransactionType.income
                            ? AppTextStyles.incomeAmount
                            : AppTextStyles.expenseAmount,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceXL),

            // Transaction Details
            _buildDetailRow(
              context,
              Icons.category_outlined,
              context.l10n.category,
              transaction.categoryName,
            ),
            _buildDetailRow(
              context,
              paymentMethod.icon,
              context.l10n.paymentMethod,
              paymentMethod.getDisplayName(context),
            ),
            _buildDetailRow(
              context,
              Icons.calendar_today_outlined,
              context.l10n.date,
              fullDate,
            ),
            _buildDetailRow(
              context,
              transactionType.icon,
              context.l10n.type,
              transactionType == TransactionType.income 
                ? context.l10n.income 
                : context.l10n.expense,
            ),

            // Description (if available)
            if (transaction.description.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.spaceM),
              _buildDetailSection(
                context,
                Icons.description_outlined,
                context.l10n.description,
                transaction.description,
              ),
            ],

            const SizedBox(height: AppDimensions.spaceXL),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // TODO: Implement edit functionality
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(context.l10n.edit),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                      side: BorderSide(color: AppColors.primary),
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceM),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // TODO: Implement delete functionality
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: Text(context.l10n.delete),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                      side: BorderSide(color: AppColors.error),
                      foregroundColor: AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
            
            // Bottom padding for safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppDimensions.iconS,
            color: AppColors.onSurfaceVariant,
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                Text(
                  value,
                  style: AppTextStyles.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context, IconData icon, String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconS,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceS),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: AppDimensions.borderRadiusM,
          ),
          child: Text(
            content,
            style: AppTextStyles.bodyLarge,
          ),
        ),
      ],
    );
  }
}