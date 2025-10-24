import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:expense_tracker_mobile/presentation/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final BudgetItem budget;

  const BudgetCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: isDarkMode ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: isDarkMode ? Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2), width: 1) : null,
        boxShadow: isDarkMode
            ? null
            : [BoxShadow(color: theme.shadowColor.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Padding(
            padding: AppDimensions.paddingAllM,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        budget.name,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spaceS),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingS,
                        vertical: AppDimensions.paddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: budget.isOverBudget
                            ? AppColors.error.withValues(alpha: 0.1)
                            : AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                        border: Border.all(
                          color: budget.isOverBudget
                              ? AppColors.error.withValues(alpha: 0.3)
                              : AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        '${budget.percentage.toStringAsFixed(1)}%',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: budget.isOverBudget ? AppColors.error : AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spaceS),
                Row(
                  children: [
                    Text(
                      LocalizationUtils.formatCurrency(context, budget.used.toDouble()),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ' / ${LocalizationUtils.formatCurrency(context, budget.allocated.toDouble())}',
                      style: AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.spaceS),
              ],
            ),
          ),
          Container(
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? theme.colorScheme.outline.withValues(alpha: 0.2)
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? theme.colorScheme.outline.withValues(alpha: 0.2)
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: (budget.percentage / 100).clamp(0.0, 1.0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: budget.isOverBudget ? AppColors.error : AppColors.success,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.used,
                  style: AppTextStyles.labelSmall.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                Text(
                  budget.isOverBudget ? context.l10n.overBudget : context.l10n.withinBudget,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: budget.isOverBudget ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
