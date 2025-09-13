import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/presentation/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<HomeBloc>();
    _bloc.add(HomeStarted());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _getGreeting(context),
          style: AppTextStyles.headlineMedium.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              // TODO: Navigate to profile
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _bloc,
        builder: (context, state) {
          return SafeArea(child: _buildBody(context, state));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is HomeError) {
      return Center(
        child: Padding(
          padding: AppDimensions.paddingAllL,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: AppDimensions.spaceM),
              Text(
                context.l10n.somethingWentWrong,
                style: AppTextStyles.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spaceS),
              Text(
                state.message,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spaceL),
              ElevatedButton(
                onPressed: () => _bloc.add(HomeRefresh()),
                child: Text(context.l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (state is HomeLoaded) {
      return RefreshIndicator(
        onRefresh: () async {
          _bloc.add(HomeRefresh());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: AppDimensions.paddingAllM,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              _buildOverviewSection(state),

              const SizedBox(height: AppDimensions.spaceXL),

              // Recent Budget Section
              _buildRecentBudgetSection(state),

              const SizedBox(height: AppDimensions.spaceXL),

              // Recent Transactions Section
              _buildRecentTransactionsSection(state),

              const SizedBox(height: AppDimensions.spaceXL),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildOverviewSection(HomeLoaded state) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.overview,
              style: AppTextStyles.headlineSmall.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingS,
                vertical: AppDimensions.paddingXS,
              ),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? theme.colorScheme.surfaceContainerHighest
                    : AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                border: theme.brightness == Brightness.dark
                    ? Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state.currentFilter,
                  isDense: true,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? theme.colorScheme.onSurface
                        : AppColors.primary,
                  ),
                  dropdownColor: theme.brightness == Brightness.dark
                      ? theme.colorScheme.surfaceContainerHighest
                      : theme.colorScheme.surface,
                  iconEnabledColor: theme.brightness == Brightness.dark
                      ? theme.colorScheme.onSurface
                      : AppColors.primary,
                  items:
                      [
                        context.l10n.monthly,
                        context.l10n.weekly,
                        context.l10n.yearly,
                      ].map((filter) {
                        return DropdownMenuItem(
                          value: filter,
                          child: Text(
                            filter,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: theme.brightness == Brightness.dark
                                  ? theme.colorScheme.onSurface
                                  : AppColors.primary,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _bloc.add(FilterChanged(filter: value));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Row(
          children: [
            Expanded(
              child: _buildFinancialCard(
                title: context.l10n.totalIncome,
                amount: state.totalIncome,
                color: AppColors.success,
                icon: Icons.trending_up,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: _buildFinancialCard(
                title: context.l10n.totalExpense,
                amount: state.totalExpense,
                color: AppColors.error,
                icon: Icons.trending_down,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFinancialCard({
    required String title,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: AppDimensions.paddingAllM,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark 
            ? color.withValues(alpha: 0.15) 
            : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: theme.brightness == Brightness.dark 
              ? color.withValues(alpha: 0.4) 
              : color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: AppDimensions.spaceS),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.labelMedium.copyWith(color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: AppTextStyles.headlineMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBudgetSection(HomeLoaded state) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.recentBudget,
          style: AppTextStyles.headlineSmall.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Column(
          children: state.recentBudgets
              .map((budget) => _buildBudgetCard(budget))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildBudgetCard(BudgetItem budget) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      padding: AppDimensions.paddingAllM,
      decoration: BoxDecoration(
        color: isDarkMode
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: isDarkMode
            ? Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
                width: 1,
              )
            : null,
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                budget.name,
                style: AppTextStyles.titleMedium.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                '\$${budget.used.toStringAsFixed(2)} / \$${budget.allocated.toStringAsFixed(2)}',
                style: AppTextStyles.labelMedium.copyWith(
                  color: budget.isOverBudget
                      ? AppColors.error
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          LinearProgressIndicator(
            value: budget.percentage / 100,
            backgroundColor: isDarkMode
                ? theme.colorScheme.outline.withValues(alpha: 0.2)
                : theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(
              budget.isOverBudget ? AppColors.error : AppColors.success,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceXS),
          Text(
            '${budget.percentage.toStringAsFixed(1)}% ${context.l10n.used}',
            style: AppTextStyles.labelSmall.copyWith(
              color: budget.isOverBudget
                  ? AppColors.error
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsSection(HomeLoaded state) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.recentTransactions,
          style: AppTextStyles.headlineSmall.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Column(
          children: state.recentTransactions
              .map((transaction) => _buildTransactionItem(transaction))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(TransactionItem transaction) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      padding: AppDimensions.paddingAllM,
      decoration: BoxDecoration(
        color: isDarkMode
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: isDarkMode
            ? Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
                width: 1,
              )
            : null,
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: transaction.isExpense
                    ? (isDarkMode
                          ? AppColors.error.withValues(alpha: 0.2)
                          : AppColors.error.withValues(alpha: 0.1))
                    : (isDarkMode
                          ? AppColors.success.withValues(alpha: 0.2)
                          : AppColors.success.withValues(alpha: 0.1)),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                _getCategoryIcon(transaction.category),
                color: transaction.isExpense
                    ? AppColors.error
                    : AppColors.success,
                size: 20,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    transaction.description,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(transaction.date, context),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.spaceS),
            Text(
              '${transaction.isExpense ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
              style: AppTextStyles.titleMedium.copyWith(
                color: transaction.isExpense
                    ? AppColors.error
                    : AppColors.success,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'transport':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'income':
        return Icons.attach_money;
      default:
        return Icons.receipt;
    }
  }

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return context.l10n.goodMorning;
    } else if (hour < 17) {
      return context.l10n.goodAfternoon;
    } else {
      return context.l10n.goodEvening;
    }
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
