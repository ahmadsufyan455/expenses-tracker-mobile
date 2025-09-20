import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/enums/transaction_enums.dart';
import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/transaction_dto.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction, this.onTap});

  final TransactionDto transaction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionType = TransactionType.fromString(transaction.type);
    final paymentMethod = PaymentMethod.fromString(transaction.paymentMethod.toLowerCase().replaceAll(' ', '_'));
    final amount = transaction.amount.abs();
    final formattedAmount = LocalizationUtils.formatCurrency(context, amount.toDouble());
    final relativeDate = LocalizationUtils.getRelativeDate(context, transaction.createdAt);

    return Container(
      margin: AppDimensions.paddingVerticalS,
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: AppDimensions.borderRadiusM,
        elevation: AppDimensions.cardElevation,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppDimensions.borderRadiusM,
          child: Padding(
            padding: AppDimensions.paddingAllM,
            child: Row(
              children: [
                _buildTransactionIcon(transactionType),
                const SizedBox(width: AppDimensions.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              transaction.category.name,
                              style: theme.textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${transactionType == TransactionType.income ? '+' : '-'}$formattedAmount',
                            style: transactionType == TransactionType.income
                                ? AppTextStyles.incomeAmount.copyWith(fontSize: 16)
                                : AppTextStyles.expenseAmount.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceXS),
                      Row(
                        children: [
                          Icon(
                            paymentMethod.icon,
                            size: AppDimensions.iconXS,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppDimensions.spaceXS),
                          Text(
                            paymentMethod.getDisplayName(context),
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(width: AppDimensions.spaceS),
                          Icon(Icons.circle, size: 4, color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: AppDimensions.spaceS),
                          Text(
                            relativeDate,
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                      if (transaction.description != null && transaction.description!.isNotEmpty) ...[
                        const SizedBox(height: AppDimensions.spaceXS),
                        Text(
                          transaction.description!,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionIcon(TransactionType transactionType) {
    return Container(
      width: AppDimensions.iconXL,
      height: AppDimensions.iconXL,
      decoration: BoxDecoration(shape: BoxShape.circle, color: transactionType.backgroundColor),
      child: Icon(transactionType.icon, size: AppDimensions.iconM, color: transactionType.color),
    );
  }
}
