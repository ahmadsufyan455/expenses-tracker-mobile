import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/date_utils.dart' as app_date_utils;
import 'package:expense_tracker_mobile/presentation/pages/home/bloc/home_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/home/financial_summary_card.dart';
import 'package:expense_tracker_mobile/presentation/widgets/home/section_header.dart';
import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  final HomeLoaded state;
  final Function(String) onFilterChanged;

  const OverviewSection({super.key, required this.state, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: context.l10n.overview, trailing: _buildFilterDropdown(context, theme)),

        // Main financial cards
        Row(
          children: [
            Expanded(
              child: FinancialSummaryCard(
                title: context.l10n.totalIncome,
                amount: state.totalIncome,
                color: AppColors.success,
                icon: Icons.trending_up_rounded,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: FinancialSummaryCard(
                title: context.l10n.totalExpense,
                amount: state.totalExpense,
                color: AppColors.error,
                icon: Icons.trending_down_rounded,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppDimensions.spaceM),

        // Secondary financial cards
        Row(
          children: [
            Expanded(
              child: FinancialSummaryCard(
                title: context.l10n.netBalance,
                amount: state.netBalance,
                color: state.netBalance >= 0 ? AppColors.success : AppColors.error,
                icon: state.netBalance >= 0 ? Icons.account_balance_wallet_rounded : Icons.money_off_rounded,
                isCompact: true,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: FinancialSummaryCard(
                title: context.l10n.todayExpenses,
                amount: state.totalExpenseToday,
                color: AppColors.error,
                icon: Icons.money_rounded,
                isCompact: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterDropdown(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingS),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: state.currentFilter,
          isDense: true,
          style: AppTextStyles.labelMedium.copyWith(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600),
          dropdownColor: theme.colorScheme.surfaceContainerHighest,
          iconEnabledColor: theme.colorScheme.onSurface,
          items: app_date_utils.AppDateUtils.getAvailableMonthFilters().map((filter) {
            return DropdownMenuItem(
              value: filter,
              child: Text(app_date_utils.AppDateUtils.formatFilterToDisplayName(context, filter)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onFilterChanged(value);
            }
          },
        ),
      ),
    );
  }
}
