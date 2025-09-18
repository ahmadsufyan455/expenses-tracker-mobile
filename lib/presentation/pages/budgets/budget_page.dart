import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/domain/dto/budget_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/budgets/bloc/budget_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/budget/add_budget_bottom_sheet.dart';
import 'package:expense_tracker_mobile/presentation/widgets/budget/budget_item.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late BudgetBloc _bloc;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<BudgetBloc>()..add(GetBudgetEvent());
  }

  Future<void> _onRefresh() async {
    _bloc.add(GetBudgetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.budgets),
        actions: [
          IconButton(
            onPressed: _showAddBudgetBottomSheet,
            icon: const Icon(Icons.add),
            tooltip: context.l10n.addNewBudgetTooltip,
          ),
        ],
      ),
      body: BlocConsumer<BudgetBloc, BudgetState>(
        bloc: _bloc,
        listener: (context, state) {
          _handleBudgetState(state);
        },
        builder: (context, state) {
          if (state is GetBudgetLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final budgets = state.data.budgets;

          if (budgets.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: ListView.builder(
              padding: AppDimensions.paddingAllM,
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                final budget = budgets[index];
                return BudgetItem(
                  budget: budget,
                  categories: state.data.categories,
                  onTap: () => _showEditBudgetBottomSheet(budget),
                  onDelete: () => _deleteBudget(budget.id),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppDimensions.paddingAllL,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pie_chart_outline, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: AppDimensions.spaceL),
            Text(
              context.l10n.budgets,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              context.l10n.manageBudgetsSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceXL),
            ElevatedButton.icon(
              onPressed: _showAddBudgetBottomSheet,
              icon: const Icon(Icons.add),
              label: Text(context.l10n.addBudget),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                  vertical: AppDimensions.paddingM,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddBudgetBottomSheet() async {
    final result = await AddBudgetBottomSheet.show(context, categories: _bloc.stateData.categories);
    if (result == true) {
      _bloc.add(GetBudgetEvent());
    }
  }

  Future<void> _showEditBudgetBottomSheet(BudgetDto budget) async {
    final result = await AddBudgetBottomSheet.show(
      context,
      budget: budget,
      categories: _bloc.stateData.categories,
    );
    if (result == true) {
      _bloc.add(GetBudgetEvent());
    }
  }

  void _deleteBudget(int budgetId) {
    _bloc.add(DeleteBudgetEvent(id: budgetId));
  }

  void _handleBudgetState(BudgetState state) {
    if (state is GetBudgetFailure) {
      ErrorDialog.show(context, state.failure);
    } else if (state is CreateBudgetSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.budgetAddedSuccessfully), backgroundColor: Colors.green),
      );
    } else if (state is CreateBudgetFailure) {
      ErrorDialog.show(context, state.failure);
    } else if (state is UpdateBudgetSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.budgetUpdatedSuccessfully), backgroundColor: Colors.green),
      );
    } else if (state is UpdateBudgetFailure) {
      ErrorDialog.show(context, state.failure);
    } else if (state is DeleteBudgetSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.budgetDeletedSuccessfully), backgroundColor: Colors.green),
      );
      _bloc.add(GetBudgetEvent()); // Refresh the list
    } else if (state is DeleteBudgetFailure) {
      ErrorDialog.show(context, state.failure);
    }
  }
}