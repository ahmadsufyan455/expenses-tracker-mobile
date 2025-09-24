import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/category_icon_utils.dart';
import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:expense_tracker_mobile/presentation/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class TransactionItemCard extends StatelessWidget {
  final TransactionItem transaction;

  const TransactionItemCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      padding: AppDimensions.paddingAllM,
      decoration: BoxDecoration(
        color: isDarkMode ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: isDarkMode ? Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.15), width: 1) : null,
        boxShadow: isDarkMode
            ? null
            : [BoxShadow(color: theme.shadowColor.withValues(alpha: 0.06), blurRadius: 6, offset: const Offset(0, 1))],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: transaction.isExpense
                  ? (isDarkMode ? AppColors.error.withValues(alpha: 0.2) : AppColors.error.withValues(alpha: 0.1))
                  : (isDarkMode ? AppColors.success.withValues(alpha: 0.2) : AppColors.success.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(
                color: transaction.isExpense
                    ? AppColors.error.withValues(alpha: 0.3)
                    : AppColors.success.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              CategoryIconUtils.getCategoryIcon(transaction.category),
              color: transaction.isExpense ? AppColors.error : AppColors.success,
              size: 22,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction.description,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDate(transaction.date, context),
                  style: AppTextStyles.labelMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction.isExpense ? '-' : '+'}${LocalizationUtils.formatCurrency(context, transaction.amount.toDouble())}',
                style: AppTextStyles.titleMedium.copyWith(
                  color: transaction.isExpense ? AppColors.error : AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS, vertical: 2),
                decoration: BoxDecoration(
                  color: transaction.isExpense
                      ? AppColors.error.withValues(alpha: 0.1)
                      : AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Text(
                  transaction.isExpense ? context.l10n.expense : context.l10n.income,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: transaction.isExpense ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return context.l10n.today;
    } else if (difference.inDays == 1) {
      return context.l10n.yesterday;
    } else if (difference.inDays < 7) {
      return context.l10n.daysAgo(difference.inDays);
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
