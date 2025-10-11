import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/number_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/dashboard_dto.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TopExpensesPieChart extends StatelessWidget {
  final List<DashboardTopExpenseDto> topExpenses;

  const TopExpensesPieChart({super.key, required this.topExpenses});

  @override
  Widget build(BuildContext context) {
    if (topExpenses.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            context.l10n.noDataAvailable,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: _buildPieSections(context),
          centerSpaceRadius: 40,
          sectionsSpace: 2,
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              // Handle touch events if needed
            },
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieSections(BuildContext context) {
    final theme = Theme.of(context);

    return topExpenses.asMap().entries.map((entry) {
      final index = entry.key;
      final expense = entry.value;
      final color = AppColors.chartColors[index % AppColors.chartColors.length];

      return PieChartSectionData(
        value: expense.amount.toDouble(),
        title: '${expense.percentage.toStringAsFixed(1)}%',
        color: color,
        radius: 50,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.colorScheme.onPrimary),
      );
    }).toList();
  }
}

class TopExpensesLegend extends StatelessWidget {
  final List<DashboardTopExpenseDto> topExpenses;

  const TopExpensesLegend({super.key, required this.topExpenses});

  @override
  Widget build(BuildContext context) {
    if (topExpenses.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: topExpenses.asMap().entries.map((entry) {
        final index = entry.key;
        final expense = entry.value;
        final color = AppColors.chartColors[index % AppColors.chartColors.length];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  expense.category,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface),
                ),
              ),
              Text(
                'Rp ${NumberUtils.formatWithThousandSeparator(expense.amount.toInt())}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
