import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:flutter/material.dart';

class FinancialSummaryCard extends StatelessWidget {
  final String title;
  final int amount;
  final Color color;
  final IconData icon;
  final bool isCompact;

  const FinancialSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: isCompact ? AppDimensions.paddingAllS : AppDimensions.paddingAllM,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? color.withValues(alpha: 0.15) : color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: theme.brightness == Brightness.dark ? color.withValues(alpha: 0.3) : color.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: theme.brightness == Brightness.dark
            ? null
            : [BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingXS),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Icon(icon, color: color, size: isCompact ? 16 : 20),
              ),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(
                child: Text(
                  title,
                  style: (isCompact ? AppTextStyles.labelSmall : AppTextStyles.labelMedium).copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: isCompact ? AppDimensions.spaceXS : AppDimensions.spaceS),
          Text(
            LocalizationUtils.formatCurrency(context, amount.toDouble()),
            style: (isCompact ? AppTextStyles.titleSmall : AppTextStyles.titleLarge).copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class SavingsRateCard extends StatelessWidget {
  final String title;
  final double rate;
  final bool isCompact;

  const SavingsRateCard({super.key, required this.title, required this.rate, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color color = rate >= 20
        ? AppColors.success
        : rate >= 10
        ? Colors.orange
        : AppColors.error;

    return Container(
      padding: isCompact ? AppDimensions.paddingAllS : AppDimensions.paddingAllM,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? color.withValues(alpha: 0.15) : color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: theme.brightness == Brightness.dark ? color.withValues(alpha: 0.3) : color.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: theme.brightness == Brightness.dark
            ? null
            : [BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingXS),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Icon(Icons.savings, color: color, size: isCompact ? 16 : 20),
              ),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(
                child: Text(
                  title,
                  style: (isCompact ? AppTextStyles.labelSmall : AppTextStyles.labelMedium).copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: isCompact ? AppDimensions.spaceXS : AppDimensions.spaceS),
          Text(
            '${rate.toStringAsFixed(1)}%',
            style: (isCompact ? AppTextStyles.titleSmall : AppTextStyles.titleLarge).copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
