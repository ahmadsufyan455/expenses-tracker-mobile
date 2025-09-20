import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/enums/budget_enums.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/budget_dto.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetItem extends StatelessWidget {
  const BudgetItem({super.key, required this.budget, required this.categories, this.onTap, this.onDelete});

  final BudgetDto budget;
  final List<CategoryDto> categories;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final category = categories.firstWhere(
      (cat) => cat.id == budget.categoryId,
      orElse: () => CategoryDto(id: budget.categoryId, name: 'Unknown'),
    );

    // Format budget amount
    final formattedAmount = LocalizationUtils.formatCurrency(context, budget.amount.toDouble());

    // Format month
    final monthDate = DateTime.parse(budget.month);
    final formattedMonth = DateFormat.yMMMM().format(monthDate);

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: theme.brightness == Brightness.dark
            ? Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
                width: 1,
              )
            : null,
        boxShadow: theme.brightness == Brightness.dark
            ? null
            : [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Padding(
          padding: AppDimensions.paddingAllM,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with category and actions
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(category.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: AppDimensions.spaceXS),
                        Text(
                          formattedMonth,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  // Action buttons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: onTap,
                        icon: const Icon(Icons.edit_outlined),
                        iconSize: 20,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        padding: EdgeInsets.zero,
                        tooltip: context.l10n.editBudget,
                      ),
                      const SizedBox(width: AppDimensions.spaceXS),
                      IconButton(
                        onPressed: () => _showDeleteConfirmation(context),
                        icon: const Icon(Icons.delete_outline),
                        iconSize: 20,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        padding: EdgeInsets.zero,
                        tooltip: context.l10n.deleteBudget,
                        color: AppColors.error,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceM),

              // Budget amount
              Container(
                width: double.infinity,
                padding: AppDimensions.paddingAllM,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: AppDimensions.borderRadiusS,
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet_outlined, color: AppColors.primary, size: 20),
                    const SizedBox(width: AppDimensions.spaceS),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.budgetAmount,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formattedAmount,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Prediction information
              if (budget.predictionEnabled && budget.prediction != null) ...[
                const SizedBox(height: AppDimensions.spaceM),
                Container(
                  width: double.infinity,
                  padding: AppDimensions.paddingAllM,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: AppDimensions.borderRadiusS,
                    border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(budget.predictionType?.icon ?? Icons.insights_outlined, color: Colors.blue, size: 20),
                          const SizedBox(width: AppDimensions.spaceS),
                          Text(
                            context.l10n.predictionTitle,
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      Row(
                        children: [
                          Expanded(
                            child: _buildPredictionInfo(
                              context,
                              context.l10n.dailyAllowance,
                              LocalizationUtils.formatCurrency(context, budget.prediction!.dailyAllowance.toDouble()),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spaceM),
                          Expanded(
                            child: _buildPredictionInfo(
                              context,
                              context.l10n.daysRemaining,
                              budget.prediction!.daysRemaining.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      _buildPredictionInfo(
                        context,
                        context.l10n.remainingBudget,
                        LocalizationUtils.formatCurrency(context, budget.prediction!.remainingBudget.toDouble()),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPredictionInfo(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue.shade700, fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.blue.shade800, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    ConfirmationDialog.show(
      context,
      title: context.l10n.deleteBudget,
      content: context.l10n.deleteBudgetConfirmation,
      confirmText: context.l10n.delete,
      isDestructive: true,
      onConfirm: onDelete,
    );
  }
}
