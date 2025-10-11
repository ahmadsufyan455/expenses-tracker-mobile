import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/enums/budget_enums.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

/// Widget for filtering budgets by status
class BudgetFilter extends StatelessWidget {
  const BudgetFilter({super.key, required this.selectedStatus, required this.onStatusChanged});

  final BudgetStatus? selectedStatus;
  final ValueChanged<BudgetStatus?> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.spaceS),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: context.l10n.all,
                  isSelected: selectedStatus == null,
                  onTap: () => onStatusChanged(null),
                ),
                const SizedBox(width: AppDimensions.spaceS),
                ...BudgetStatus.values.map((status) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppDimensions.spaceS),
                    child: _buildFilterChip(
                      context,
                      label: status.getDisplayName(context),
                      icon: status.icon,
                      color: status.color,
                      isSelected: selectedStatus == status,
                      onTap: () => onStatusChanged(status),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    IconData? icon,
    Color? color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final chipColor = color ?? theme.colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? chipColor.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? chipColor.withValues(alpha: 0.5) : theme.colorScheme.outline.withValues(alpha: 0.3),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: isSelected ? chipColor : theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? chipColor : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
