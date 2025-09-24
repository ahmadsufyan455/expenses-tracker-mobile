import 'package:expense_tracker_mobile/app/router.dart';
import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/transaction_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/transactions/bloc/transaction_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/transaction/transaction_detail_bottom_sheet.dart';
import 'package:expense_tracker_mobile/presentation/widgets/transaction/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late TransactionBloc _bloc;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<TransactionBloc>()..add(GetTransactionEvent());
  }

  Future<void> _onRefresh() async {
    _bloc.add(GetTransactionEvent());
  }

  Map<String, List<TransactionDto>> _groupTransactionsBySection(
    BuildContext context,
    List<TransactionDto> transactions,
  ) {
    final Map<String, List<TransactionDto>> grouped = {};

    for (final transaction in transactions) {
      final section = LocalizationUtils.getTransactionSection(context, transaction.date);
      if (grouped[section] == null) {
        grouped[section] = [];
      }
      grouped[section]!.add(transaction);
    }

    return grouped;
  }

  List<dynamic> _buildSectionedList(BuildContext context, List<TransactionDto> transactions, bool isLoadingMore) {
    final grouped = _groupTransactionsBySection(context, transactions);
    final List<dynamic> sectionedList = [];

    // Define section order
    final sectionOrder = [context.l10n.today, context.l10n.yesterday, context.l10n.past];

    for (final sectionName in sectionOrder) {
      if (grouped[sectionName] != null && grouped[sectionName]!.isNotEmpty) {
        sectionedList.add(sectionName); // Add section header
        sectionedList.addAll(grouped[sectionName]!); // Add transactions
      }
    }

    // Add loading indicator if needed
    if (isLoadingMore) {
      sectionedList.add('loading');
    }

    return sectionedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.transactions),
        actions: [
          IconButton(
            onPressed: _navigateToAddTransaction,
            icon: const Icon(Icons.add),
            tooltip: context.l10n.addTransaction,
          ),
        ],
      ),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        bloc: _bloc,
        listener: (context, state) {
          _handleTransactionState(state);
        },
        builder: (context, state) {
          if (state is GetTransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final transactions = state.data.transactions;

          if (transactions.isEmpty) {
            return _buildEmptyState();
          }

          final sectionedList = _buildSectionedList(context, transactions, state.data.isLoadingMore);

          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200 &&
                    state.data.hasMoreData &&
                    !state.data.isLoadingMore) {
                  _bloc.add(GetMoreTransactionEvent());
                }
                return false;
              },
              child: ListView.builder(
                padding: AppDimensions.paddingAllM,
                itemCount: sectionedList.length,
                itemBuilder: (context, index) {
                  final item = sectionedList[index];

                  // Show loading indicator
                  if (item == 'loading') {
                    return const Padding(
                      padding: EdgeInsets.all(AppDimensions.paddingM),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // Show section header
                  if (item is String) {
                    return _buildSectionHeader(item);
                  }

                  // Show transaction item
                  if (item is TransactionDto) {
                    return TransactionItem(
                      transaction: item,
                      onTap: () async {
                        final shouldRefresh = await TransactionDetailBottomSheet.show(context, item);

                        if (shouldRefresh == true) {
                          _bloc.add(GetTransactionEvent());
                        }
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String sectionName) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingL,
        bottom: AppDimensions.paddingS,
        left: AppDimensions.paddingXS,
        right: AppDimensions.paddingXS,
      ),
      child: Text(
        sectionName,
        style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
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
            Icon(Icons.receipt_long_outlined, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: AppDimensions.spaceL),
            Text(context.l10n.transactions, style: theme.textTheme.headlineMedium),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              context.l10n.manageTransactions,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceXL),
            ElevatedButton.icon(
              onPressed: () => _navigateToAddTransaction(),
              icon: const Icon(Icons.add),
              label: Text(context.l10n.addTransaction),
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

  Future<void> _navigateToAddTransaction() async {
    final result = await Navigator.pushNamed(context, RouteName.addTransaction.path);

    // Refresh the transaction list if a new transaction was added
    if (result == true) {
      _bloc.add(GetTransactionEvent());
    }
  }

  void _handleTransactionState(TransactionState state) {
    if (state is GetTransactionFailure) {
      ErrorDialog.show(context, state.failure);
    }
  }
}
