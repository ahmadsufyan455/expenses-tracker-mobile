import 'package:expense_tracker_mobile/app/router.dart';
import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/date_utils.dart' as app_date_utils;
import 'package:expense_tracker_mobile/core/utils/preference_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/dashboard_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/home/bloc/home_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/dashboard/top_expenses_pie_chart.dart';
import 'package:expense_tracker_mobile/presentation/widgets/home/budget_card.dart';
import 'package:expense_tracker_mobile/presentation/widgets/home/overview_section.dart';
import 'package:expense_tracker_mobile/presentation/widgets/home/section_header.dart';
import 'package:expense_tracker_mobile/presentation/widgets/home/transaction_item_card.dart';
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
    _initializeWithDefaultFilter();
  }

  Future<void> _initializeWithDefaultFilter() async {
    // Get saved default filter or fall back to current month
    final defaultFilter = await PreferenceUtils.getDefaultDashboardFilter();
    final filter = defaultFilter ?? app_date_utils.AppDateUtils.getCurrentMonthFilter();
    _bloc.add(HomeStarted(filter));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: Text(_getGreeting(context))),
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
      return _buildErrorState(state);
    }

    if (state is HomeLoaded) {
      return RefreshIndicator(
        onRefresh: () async {
          _bloc.add(HomeRefresh(state.currentFilter));
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              OverviewSection(state: state, onFilterChanged: (filter) => _bloc.add(FilterChanged(filter))),

              const SizedBox(height: AppDimensions.spaceM),

              // Charts Section
              _buildChartsSection(state),

              const SizedBox(height: AppDimensions.spaceXL),

              // Recent Budget Section
              _buildRecentBudgetSection(state),

              const SizedBox(height: AppDimensions.spaceXL),

              // Recent Transactions Section
              _buildRecentTransactionsSection(state),

              const SizedBox(height: AppDimensions.spaceXL + AppDimensions.spaceM),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorState(HomeError state) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppDimensions.paddingAllL,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: AppDimensions.paddingAllL,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
              ),
              child: Icon(Icons.error_outline_rounded, size: 64, color: AppColors.error),
            ),
            const SizedBox(height: AppDimensions.spaceL),
            Text(
              context.l10n.somethingWentWrong,
              style: AppTextStyles.headlineSmall.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              state.message,
              style: AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceL),
            ElevatedButton.icon(
              onPressed: () => _bloc.add(HomeRefresh(state.filter)),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(context.l10n.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                  vertical: AppDimensions.paddingM,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBudgetSection(HomeLoaded state) {
    if (state.recentBudgets.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: context.l10n.recentBudget,
          actionText: context.l10n.viewAll,
          onActionTap: () {
            Navigator.pushReplacementNamed(
              context,
              RouteName.home.path,
              arguments: {'initialIndex': 1}, // Budget page is index 1
            );
          },
        ),
        ...state.recentBudgets.map((budget) => BudgetCard(budget: budget)),
      ],
    );
  }

  Widget _buildRecentTransactionsSection(HomeLoaded state) {
    if (state.recentTransactions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: context.l10n.recentTransactions,
          actionText: context.l10n.viewAll,
          onActionTap: () {
            Navigator.pushReplacementNamed(
              context,
              RouteName.home.path,
              arguments: {'initialIndex': 2}, // Transactions page is index 2
            );
          },
        ),
        ...state.recentTransactions.map((transaction) => TransactionItemCard(transaction: transaction)),
      ],
    );
  }

  Widget _buildChartsSection(HomeLoaded state) {
    // Convert HomeLoaded data to chart-compatible data
    final topExpenses = state.topExpenses
        .map(
          (expense) => DashboardTopExpenseDto(
            category: expense.category,
            amount: expense.amount,
            percentage: expense.percentage,
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppDimensions.spaceM),

        // Top Expenses Pie Chart
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.topExpenses,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TopExpensesPieChart(topExpenses: topExpenses),
              const SizedBox(height: 12),
              TopExpensesLegend(topExpenses: topExpenses),
            ],
          ),
        ),
      ],
    );
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
}
