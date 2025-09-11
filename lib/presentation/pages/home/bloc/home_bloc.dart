import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeRefresh>(_onHomeRefresh);
    on<FilterChanged>(_onFilterChanged);
  }

  Future<void> _onHomeStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await _loadHomeData(emit, 'Monthly');
  }

  Future<void> _onHomeRefresh(
    HomeRefresh event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(HomeLoading());
      await _loadHomeData(emit, currentState.currentFilter);
    } else {
      await _loadHomeData(emit, 'Monthly');
    }
  }

  Future<void> _onFilterChanged(
    FilterChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await _loadHomeData(emit, event.filter);
  }

  Future<void> _loadHomeData(Emitter<HomeState> emit, String filter) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API calls later
      final mockBudgets = [
        const BudgetItem(
          name: 'Food & Dining',
          allocated: 500.0,
          used: 320.0,
          category: 'food',
        ),
        const BudgetItem(
          name: 'Transportation',
          allocated: 300.0,
          used: 280.0,
          category: 'transport',
        ),
        const BudgetItem(
          name: 'Entertainment',
          allocated: 200.0,
          used: 250.0,
          category: 'entertainment',
        ),
      ];

      final mockTransactions = [
        TransactionItem(
          id: '1',
          amount: 25.50,
          description: 'Coffee Shop',
          category: 'food',
          date: DateTime.now().subtract(const Duration(hours: 2)),
          isExpense: true,
        ),
        TransactionItem(
          id: '2',
          amount: 1200.00,
          description: 'Salary',
          category: 'income',
          date: DateTime.now().subtract(const Duration(days: 1)),
          isExpense: false,
        ),
        TransactionItem(
          id: '3',
          amount: 45.00,
          description: 'Gas Station',
          category: 'transport',
          date: DateTime.now().subtract(const Duration(days: 2)),
          isExpense: true,
        ),
        TransactionItem(
          id: '4',
          amount: 15.00,
          description: 'Movie Ticket',
          category: 'entertainment',
          date: DateTime.now().subtract(const Duration(days: 3)),
          isExpense: true,
        ),
      ];

      // Calculate totals
      double totalIncome = 0;
      double totalExpense = 0;
      
      for (final transaction in mockTransactions) {
        if (transaction.isExpense) {
          totalExpense += transaction.amount;
        } else {
          totalIncome += transaction.amount;
        }
      }

      emit(HomeLoaded(
        totalIncome: totalIncome,
        totalExpense: totalExpense,
        currentFilter: filter,
        recentBudgets: mockBudgets,
        recentTransactions: mockTransactions.take(3).toList(),
      ));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}