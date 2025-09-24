import 'package:expense_tracker_mobile/app/router.dart';
import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/enums/transaction_enums.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/localization_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/transaction_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/transactions/bloc/transaction_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/confirmation_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TransactionDetailBottomSheet extends StatefulWidget {
  const TransactionDetailBottomSheet({super.key, required this.transaction});

  final TransactionDto transaction;

  static Future<bool?> show(BuildContext context, TransactionDto transaction) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionDetailBottomSheet(transaction: transaction),
    );
  }

  @override
  State<TransactionDetailBottomSheet> createState() => _TransactionDetailBottomSheetState();
}

class _TransactionDetailBottomSheetState extends State<TransactionDetailBottomSheet> {
  late TransactionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<TransactionBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionBloc, TransactionState>(
      bloc: _bloc,
      listener: (context, state) {
        _handleTransactionState(state);
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        final transactionType = TransactionType.fromString(widget.transaction.type);
        final paymentMethod = PaymentMethod.fromString(
          widget.transaction.paymentMethod.toLowerCase().replaceAll(' ', '_'),
        );
        final amount = widget.transaction.amount.abs();
        final formattedAmount = LocalizationUtils.formatCurrency(context, amount.toDouble());

        // Format date using localized short date format pattern
        final DateTime transactionDate = DateTime.parse(widget.transaction.date);
        final fullDate = LocalizationUtils.formatShortDate(context, transactionDate);

        final isDeleting = state is DeleteTransactionLoading;

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radiusL),
              topRight: Radius.circular(AppDimensions.radiusL),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceL),

                // Header with icon and amount
                Row(
                  children: [
                    Container(
                      width: AppDimensions.iconXL,
                      height: AppDimensions.iconXL,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: transactionType.backgroundColor),
                      child: Icon(transactionType.icon, size: AppDimensions.iconM, color: transactionType.color),
                    ),
                    const SizedBox(width: AppDimensions.spaceM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.transaction.category.name, style: theme.textTheme.headlineSmall),
                          const SizedBox(height: AppDimensions.spaceXS),
                          Text(
                            '${transactionType == TransactionType.income ? '+' : '-'}$formattedAmount',
                            style: transactionType == TransactionType.income
                                ? AppTextStyles.incomeAmount
                                : AppTextStyles.expenseAmount,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spaceXL),

                // Transaction Details
                _buildDetailRow(
                  context,
                  Icons.category_outlined,
                  context.l10n.category,
                  widget.transaction.category.name,
                ),
                _buildDetailRow(
                  context,
                  paymentMethod.icon,
                  context.l10n.paymentMethod,
                  paymentMethod.getDisplayName(context),
                ),
                _buildDetailRow(context, Icons.calendar_today_outlined, context.l10n.date, fullDate),
                _buildDetailRow(
                  context,
                  transactionType.icon,
                  context.l10n.type,
                  transactionType == TransactionType.income ? context.l10n.income : context.l10n.expense,
                ),

                // Description (if available)
                if (widget.transaction.description != null && widget.transaction.description!.isNotEmpty) ...[
                  const SizedBox(height: AppDimensions.spaceM),
                  _buildDetailSection(
                    context,
                    Icons.description_outlined,
                    context.l10n.description,
                    widget.transaction.description!,
                  ),
                ],

                const SizedBox(height: AppDimensions.spaceXL),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            RouteName.addTransaction.path,
                            arguments: {'transaction': widget.transaction, 'isUpdate': true},
                          );

                          if (result == true && context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: Text(context.l10n.edit),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                          side: BorderSide(color: AppColors.primary),
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spaceM),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: isDeleting ? null : () => _showDeleteConfirmation(context),
                        icon: isDeleting
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.delete_outline),
                        label: Text(context.l10n.delete),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                          side: BorderSide(color: AppColors.error),
                          foregroundColor: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),

                // Bottom padding for safe area
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleTransactionState(TransactionState state) {
    if (state is DeleteTransactionSuccess) {
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.transactionDeletedSuccessfully), backgroundColor: Colors.green),
      );
    } else if (state is DeleteTransactionFailure) {
      ErrorDialog.show(context, state.failure);
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    ConfirmationDialog.show(
      context,
      title: context.l10n.deleteTransaction,
      content: context.l10n.deleteTransactionConfirmation,
      confirmText: context.l10n.delete,
      isDestructive: true,
      onConfirm: () {
        _bloc.add(DeleteTransactionEvent(id: widget.transaction.id));
      },
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      child: Row(
        children: [
          Icon(icon, size: AppDimensions.iconS, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                const SizedBox(height: AppDimensions.spaceXS),
                Text(value, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context, IconData icon, String label, String content) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: AppDimensions.iconS, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: AppDimensions.spaceM),
            Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceS),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: AppDimensions.borderRadiusM,
          ),
          child: Text(content, style: theme.textTheme.bodyLarge, maxLines: 3, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
