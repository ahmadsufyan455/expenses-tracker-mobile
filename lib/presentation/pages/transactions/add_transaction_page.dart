import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/core/enums/transaction_enums.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/number_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/domain/dto/transaction_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/transactions/bloc/transaction_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_button.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_dropdown_form_field.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key, this.transaction, this.isUpdate});

  final TransactionDto? transaction;
  final bool? isUpdate;

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  PaymentMethod? _selectedPaymentMethod;

  late TransactionBloc _bloc;
  CategoryDto? _selectedCategory;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<TransactionBloc>()..add(GetCategoryEvent());
    _checkTransactionData();
  }

  void _checkTransactionData() {
    if (_isUpdate()) {
      _selectedType = TransactionType.fromString(widget.transaction!.type);
      // Don't set _selectedCategory here - it will be set when categories are loaded
      _selectedPaymentMethod = PaymentMethod.fromString(widget.transaction!.paymentMethod);
      _amountController.text = NumberUtils.formatWithThousandSeparator(widget.transaction!.amount.abs());
      // Truncate description if it's longer than 150 characters
      final description = widget.transaction!.description ?? '';
      _descriptionController.text = description.length > 150 ? description.substring(0, 150) : description;
    }
  }

  bool _isUpdate() {
    return widget.isUpdate != null && widget.isUpdate! && widget.transaction != null;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isUpdate() ? context.l10n.updateTransaction : context.l10n.addTransaction)),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        bloc: _bloc,
        listener: (context, state) {
          _handleAddTransactionState(state);
          _handleUpdateTransactionState(state);
          _handleCategoryState(state);
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Transaction Type Toggle
                  AnimatedToggleSwitch<TransactionType>.size(
                    current: _selectedType,
                    values: TransactionType.values,
                    iconOpacity: 1.0,
                    indicatorSize: const Size.fromWidth(double.infinity),
                    customIconBuilder: (context, local, global) {
                      final text = local.value == TransactionType.expense ? context.l10n.expense : context.l10n.income;
                      final isSelected = local.value == _selectedType;
                      final color = local.value.color;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            local.value.icon,
                            color: isSelected ? color : Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            text,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: isSelected ? color : Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      );
                    },
                    borderWidth: 0,
                    height: 54,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                        _selectedCategory = null;
                      });
                    },
                    style: ToggleStyle(
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderColor: Colors.transparent,
                      indicatorColor: _selectedType.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Amount Field
                  GlobalTextFormField(
                    controller: _amountController,
                    labelText: context.l10n.amount,
                    prefixText: 'Rp ',
                    keyboardType: TextInputType.number,
                    inputFormatters: [ThousandSeparatorInputFormatter()],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.pleaseEnterAmount;
                      }
                      if (!NumberUtils.isValidFormattedNumber(value)) {
                        return context.l10n.pleaseEnterValidAmount;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Category Dropdown
                  GlobalDropdownFormField<CategoryDto>(
                    value: _selectedCategory,
                    labelText: context.l10n.category,
                    items: state.data.categories
                        .map((category) => DropdownMenuItem(value: category, child: Text(category.name)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return context.l10n.pleaseSelectCategory;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Payment Method Selection
                  Text(context.l10n.paymentMethod, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: PaymentMethod.values.length,
                    itemBuilder: (context, index) {
                      final method = PaymentMethod.values[index];
                      final isSelected = _selectedPaymentMethod == method;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = method;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outline,
                              width: isSelected ? 2 : 1,
                            ),
                            color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                method.icon,
                                color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _getPaymentMethodDisplayName(method),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: isSelected
                                        ? AppColors.primary
                                        : Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Description Field
                  GlobalTextFormField(
                    controller: _descriptionController,
                    labelText: context.l10n.descriptionOptional,
                    maxLines: 3,
                    maxLength: 150,
                  ),
                  const SizedBox(height: 32),

                  // Save Button
                  GlobalButton(onPressed: _saveTransaction, text: context.l10n.saveTransaction, isLoading: _isLoading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      // Validate payment method selection
      if (_selectedPaymentMethod == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.pleaseSelectPaymentMethod), backgroundColor: Colors.red));
        return;
      }

      // Parse formatted amount (e.g., "10.000" -> 10000)
      final amount = NumberUtils.parseFromFormattedString(_amountController.text);

      if (_isUpdate()) {
        _bloc.add(
          UpdateTransactionEvent(
            id: widget.transaction!.id,
            amount: amount,
            type: _selectedType.value,
            paymentMethod: _selectedPaymentMethod!.value,
            categoryId: _selectedCategory?.id ?? 0,
            description: _descriptionController.text,
          ),
        );
      } else {
        _bloc.add(
          CreateTransactionEvent(
            amount: amount,
            type: _selectedType.value,
            paymentMethod: _selectedPaymentMethod!.value,
            categoryId: _selectedCategory?.id ?? 0,
            description: _descriptionController.text,
          ),
        );
      }
    }
  }

  void _handleAddTransactionState(TransactionState state) {
    if (state is CreateTransactionLoading) {
      _handleLoadingState(true);
    } else if (state is CreateTransactionSuccess) {
      _handleLoadingState(false);
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.transactionSavedSuccessfully), backgroundColor: Colors.green));
    } else if (state is CreateTransactionFailure) {
      _handleLoadingState(false);
      ErrorDialog.show(context, state.failure);
    }
  }

  void _handleUpdateTransactionState(TransactionState state) {
    if (state is UpdateTransactionLoading) {
      _handleLoadingState(true);
    } else if (state is UpdateTransactionSuccess) {
      _handleLoadingState(false);
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.transactionUpdatedSuccessfully), backgroundColor: Colors.green),
      );
    } else if (state is UpdateTransactionFailure) {
      _handleLoadingState(false);
      ErrorDialog.show(context, state.failure);
    }
  }

  void _handleCategoryState(TransactionState state) {
    if (state is GetCategorySuccess) {
      // Set selected category for update mode when categories are loaded
      if (_isUpdate() && _selectedCategory == null && state.data.categories.isNotEmpty) {
        final categoryId = widget.transaction!.category.id;
        final matchingCategory = state.data.categories
            .firstWhere((cat) => cat.id == categoryId, orElse: () => state.data.categories.first);

        setState(() {
          _selectedCategory = matchingCategory;
        });
      }
    }
  }

  void _handleLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  String _getPaymentMethodDisplayName(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return context.l10n.cash;
      case PaymentMethod.creditCard:
        return context.l10n.creditCard;
      case PaymentMethod.bankTransfer:
        return context.l10n.bankTransfer;
      case PaymentMethod.digitalWallet:
        return context.l10n.digitalWallet;
    }
  }
}
