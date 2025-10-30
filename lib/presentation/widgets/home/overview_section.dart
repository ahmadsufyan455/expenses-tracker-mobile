import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/date_utils.dart' as app_date_utils;
import 'package:expense_tracker_mobile/presentation/pages/home/bloc/home_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/home/financial_summary_card.dart';
import 'package:expense_tracker_mobile/presentation/widgets/home/section_header.dart';
import 'package:flutter/material.dart';

class OverviewSection extends StatefulWidget {
  final HomeLoaded state;
  final Function(String) onFilterChanged;

  const OverviewSection({super.key, required this.state, required this.onFilterChanged});

  @override
  State<OverviewSection> createState() => _OverviewSectionState();
}

class _OverviewSectionState extends State<OverviewSection> {
  HomeLoaded get state => widget.state;
  Function(String) get onFilterChanged => widget.onFilterChanged;

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
    final isCustomPeriod = app_date_utils.AppDateUtils.isCustomPeriodFilter(state.currentFilter);
    final displayText = isCustomPeriod
        ? context.l10n.customPeriod
        : app_date_utils.AppDateUtils.formatFilterToDisplayName(context, state.currentFilter);

    // Show as a button that opens bottom sheet
    return InkWell(
      onTap: () => _showFilterMenu(context),
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingS),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? theme.colorScheme.surfaceContainerHighest
              : theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayText,
              style: AppTextStyles.labelMedium.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, color: theme.colorScheme.onSurface, size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _showFilterMenu(BuildContext context) async {
    final monthFilters = app_date_utils.AppDateUtils.getAvailableMonthFilters();
    final theme = Theme.of(context);
    final isCustomPeriod = app_date_utils.AppDateUtils.isCustomPeriodFilter(state.currentFilter);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusL)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                  child: Text(
                    context.l10n.selectPeriod,
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceL),

                // Quick Filters Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                  child: Text(
                    context.l10n.quickFilters,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceS),

                // Quick Filter Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildQuickFilterCard(
                          context,
                          theme,
                          bottomSheetContext,
                          app_date_utils.AppDateUtils.getLast7DaysFilter(),
                          context.l10n.last7Days,
                          Icons.calendar_today,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spaceM),
                      Expanded(
                        child: _buildQuickFilterCard(
                          context,
                          theme,
                          bottomSheetContext,
                          app_date_utils.AppDateUtils.getLast30DaysFilter(),
                          context.l10n.last30Days,
                          Icons.calendar_month,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceL),

                // Custom Period Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                  child: InkWell(
                    onTap: () async {
                      // First pop the bottom sheet
                      Navigator.pop(bottomSheetContext);

                      // Wait a bit for the bottom sheet animation to complete
                      await Future.delayed(const Duration(milliseconds: 300));

                      // Show date range picker
                      if (context.mounted) {
                        await _showDateRangePicker(context);
                      }
                    },
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        border: Border.all(
                          color: isCustomPeriod ? AppColors.primary : theme.colorScheme.outline.withValues(alpha: 0.3),
                          width: isCustomPeriod ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppDimensions.paddingS),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                            ),
                            child: Icon(Icons.date_range_rounded, color: AppColors.onPrimary, size: 20),
                          ),
                          const SizedBox(width: AppDimensions.spaceM),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.customPeriod,
                                  style: AppTextStyles.titleSmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                if (isCustomPeriod) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    app_date_utils.AppDateUtils.formatCustomPeriodToDisplayName(
                                      context,
                                      state.currentFilter,
                                    ),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ] else ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    context.l10n.chooseCustomDateRange,
                                    style: AppTextStyles.bodySmall.copyWith(color: theme.colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceL),

                // Monthly Filters Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                  child: Text(
                    context.l10n.monthlyPeriods,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceS),

                // Monthly filters list
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: monthFilters.length,
                    itemBuilder: (context, index) {
                      final filter = monthFilters[index];
                      final isSelected = filter == state.currentFilter && !isCustomPeriod;

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                        title: Text(
                          app_date_utils.AppDateUtils.formatFilterToDisplayName(context, filter),
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? AppColors.primary : theme.colorScheme.onSurface,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 24)
                            : null,
                        onTap: () {
                          Navigator.pop(bottomSheetContext);
                          onFilterChanged(filter);
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceS),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final now = DateTime.now();

    // Parse current custom period if exists
    DateTimeRange? initialDateRange;
    if (app_date_utils.AppDateUtils.isCustomPeriodFilter(state.currentFilter)) {
      final (startDate, endDate) = app_date_utils.AppDateUtils.parseCustomPeriodFilter(state.currentFilter);
      if (startDate != null && endDate != null) {
        initialDateRange = DateTimeRange(start: startDate, end: endDate);
      }
    }

    // Default to last 30 days if no custom period
    initialDateRange ??= DateTimeRange(start: DateTime(now.year, now.month - 1, now.day), end: now);

    final selectedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: DateTime(2020),
      lastDate: now,
      helpText: context.l10n.selectCustomPeriod,
      saveText: context.l10n.apply,
    );

    if (selectedDateRange != null) {
      final filterString = app_date_utils.AppDateUtils.formatCustomPeriodFilter(
        selectedDateRange.start,
        selectedDateRange.end,
      );
      onFilterChanged(filterString);
    }
  }

  Widget _buildQuickFilterCard(
    BuildContext context,
    ThemeData theme,
    BuildContext bottomSheetContext,
    String filterValue,
    String label,
    IconData icon,
  ) {
    final isSelected = state.currentFilter == filterValue;

    return InkWell(
      onTap: () {
        Navigator.pop(bottomSheetContext);
        onFilterChanged(filterValue);
      },
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected ? AppColors.primary : theme.colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : theme.colorScheme.onSurfaceVariant, size: 24),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppColors.primary : theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
