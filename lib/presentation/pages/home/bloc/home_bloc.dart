import 'package:equatable/equatable.dart';
import 'package:expense_tracker_mobile/core/utils/date_utils.dart' as app_date_utils;
import 'package:expense_tracker_mobile/domain/usecases/get_dashboard_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDashboardUsecase _getDashboardUsecase;

  HomeBloc(this._getDashboardUsecase) : super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeRefresh>(_onHomeRefresh);
    on<FilterChanged>(_onFilterChanged);
  }

  Future<void> _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await _loadHomeData(emit, event.filter);
  }

  Future<void> _onHomeRefresh(HomeRefresh event, Emitter<HomeState> emit) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(HomeLoading());
      await _loadHomeData(emit, currentState.currentFilter);
    } else {
      await _loadHomeData(emit, event.filter);
    }
  }

  Future<void> _onFilterChanged(FilterChanged event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await _loadHomeData(emit, event.filter);
  }

  Future<void> _loadHomeData(Emitter<HomeState> emit, String filter) async {
    try {
      // Convert filter to start_date and end_date
      final (startDate, endDate) = app_date_utils.AppDateUtils.getDateRangeFromFilter(filter);

      final result = await _getDashboardUsecase.call(startDate: startDate, endDate: endDate, expenseLimit: 10);

      result.fold((failure) => emit(HomeError(message: failure.message, filter: filter)), (dashboard) {
        final budgets = dashboard.budgets
            .map(
              (budget) => BudgetItem(
                name: budget.category,
                allocated: budget.limit,
                used: budget.spent,
                category: budget.category.toLowerCase().replaceAll(' ', ''),
              ),
            )
            .toList();

        final transactions = dashboard.recentTransactions
            .map(
              (transaction) => TransactionItem(
                id: transaction.id.toString(),
                amount: transaction.amount,
                description: transaction.category,
                category: transaction.category.toLowerCase().replaceAll(' ', ''),
                date: transaction.date,
                isExpense: transaction.isExpense,
              ),
            )
            .toList();

        final topExpenses = dashboard.topExpenses
            .map(
              (expense) =>
                  TopExpenseItem(category: expense.category, amount: expense.amount, percentage: expense.percentage),
            )
            .toList();

        emit(
          HomeLoaded(
            totalIncome: dashboard.summary.totalIncome,
            totalExpense: dashboard.summary.totalExpenses,
            netBalance: dashboard.summary.netBalance,
            savingsRate: dashboard.summary.savingsRate,
            totalExpenseToday: dashboard.summary.totalExpensesToday,
            currentFilter: filter,
            recentBudgets: budgets,
            recentTransactions: transactions,
            topExpenses: topExpenses,
          ),
        );
      });
    } catch (e) {
      emit(HomeError(message: e.toString(), filter: filter));
    }
  }
}
