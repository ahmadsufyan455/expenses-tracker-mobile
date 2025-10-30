import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/date_utils.dart' as app_date_utils;
import 'package:flutter/material.dart';

class DefaultFilterBottomSheet extends StatelessWidget {
  final String? currentFilter;

  const DefaultFilterBottomSheet({super.key, this.currentFilter});

  static Future<String?> show(BuildContext context, {String? currentFilter}) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DefaultFilterBottomSheet(currentFilter: currentFilter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final monthFilters = app_date_utils.AppDateUtils.getAvailableMonthFilters();
    final isCustomPeriod = currentFilter != null && app_date_utils.AppDateUtils.isCustomPeriodFilter(currentFilter!);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusL),
          topRight: Radius.circular(AppDimensions.radiusL),
        ),
      ),
      child: SafeArea(
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
                    // Show date range picker first
                    final result = await _showDateRangePicker(context);
                    if (result != null && context.mounted) {
                      // Pop with result if date range was selected
                      Navigator.pop(context, result);
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
                                  app_date_utils.AppDateUtils.formatCustomPeriodToDisplayName(context, currentFilter!),
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
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: monthFilters.length,
                  itemBuilder: (context, index) {
                    final filter = monthFilters[index];
                    final isSelected = filter == currentFilter && !isCustomPeriod;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
                      title: Text(
                        app_date_utils.AppDateUtils.formatFilterToDisplayName(context, filter),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? AppColors.primary : theme.colorScheme.onSurface,
                        ),
                      ),
                      trailing:
                          isSelected ? Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 24) : null,
                      onTap: () {
                        Navigator.pop(context, filter);
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: AppDimensions.spaceS),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickFilterCard(
    BuildContext context,
    ThemeData theme,
    String filterValue,
    String label,
    IconData icon,
  ) {
    final isSelected = currentFilter == filterValue;

    return InkWell(
      onTap: () {
        Navigator.pop(context, filterValue);
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

  Future<String?> _showDateRangePicker(BuildContext context) async {
    final now = DateTime.now();

    // Parse current custom period if exists
    DateTimeRange? initialDateRange;
    if (currentFilter != null && app_date_utils.AppDateUtils.isCustomPeriodFilter(currentFilter!)) {
      final (startDate, endDate) = app_date_utils.AppDateUtils.parseCustomPeriodFilter(currentFilter!);
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
      return app_date_utils.AppDateUtils.formatCustomPeriodFilter(
        selectedDateRange.start,
        selectedDateRange.end,
      );
    }

    return null;
  }
}
