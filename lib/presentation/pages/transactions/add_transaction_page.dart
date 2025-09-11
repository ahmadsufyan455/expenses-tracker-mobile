import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/custom_dropdown_form_field.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PaymentMethodOption {
  final String value;
  final String label;
  final IconData icon;

  PaymentMethodOption(this.value, this.label, this.icon);
}

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'expense';
  String? _selectedCategory;
  String? _selectedPaymentMethod;

  List<String> get _expenseCategories => [
    context.l10n.foodDining,
    context.l10n.transportation,
    context.l10n.shopping,
    context.l10n.entertainment,
    context.l10n.billsUtilities,
    context.l10n.healthcare,
    context.l10n.education,
    context.l10n.others,
  ];

  List<String> get _incomeCategories => [
    context.l10n.salary,
    context.l10n.business,
    context.l10n.investment,
    context.l10n.gift,
    context.l10n.others,
  ];

  List<PaymentMethodOption> get _paymentMethods => [
    PaymentMethodOption('cash', context.l10n.cash, Icons.payments_outlined),
    PaymentMethodOption('credit_card', context.l10n.creditCard, Icons.credit_card_outlined),
    PaymentMethodOption('bank_transfer', context.l10n.bankTransfer, Icons.account_balance_outlined),
    PaymentMethodOption('digital_wallet', context.l10n.digitalWallet, Icons.wallet_outlined),
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.addTransaction)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Transaction Type Toggle
              AnimatedToggleSwitch<String>.size(
                current: _selectedType,
                values: const ['expense', 'income'],
                iconOpacity: 1.0,
                indicatorSize: const Size.fromWidth(double.infinity),
                customIconBuilder: (context, local, global) {
                  final text = local.value == 'expense' ? context.l10n.expense : context.l10n.income;
                  final isSelected = local.value == _selectedType;
                  final color = local.value == 'expense' ? Colors.red.shade700 : Colors.green.shade700;
                  
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        local.value == 'expense' ? Icons.trending_down_rounded : Icons.trending_up_rounded,
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
                    _selectedCategory = null; // Reset category when switching type
                  });
                },
                style: ToggleStyle(
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderColor: Colors.transparent,
                  indicatorColor: _selectedType == 'expense' 
                    ? Colors.red.shade100 
                    : Colors.green.shade100,
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
              CustomTextFormField(
                controller: _amountController,
                labelText: context.l10n.amount,
                prefixText: 'Rp ',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.pleaseEnterAmount;
                  }
                  if (double.tryParse(value) == null) {
                    return context.l10n.pleaseEnterValidAmount;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              CustomDropdownFormField<String>(
                value: _selectedCategory,
                labelText: context.l10n.category,
                items: (_selectedType == 'expense' ? _expenseCategories : _incomeCategories)
                    .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.pleaseSelectCategory;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Payment Method Selection
              Text(
                context.l10n.paymentMethod,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) {
                  final method = _paymentMethods[index];
                  final isSelected = _selectedPaymentMethod == method.value;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method.value;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected 
                            ? AppColors.primary 
                            : Theme.of(context).colorScheme.outline,
                          width: isSelected ? 2 : 1,
                        ),
                        color: isSelected 
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            method.icon,
                            color: isSelected 
                              ? AppColors.primary 
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              method.label,
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
              CustomTextFormField(
                controller: _descriptionController,
                labelText: context.l10n.descriptionOptional,
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: _saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  context.l10n.saveTransaction,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      // Validate payment method selection
      if (_selectedPaymentMethod == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.pleaseSelectPaymentMethod),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // TODO: Implement save transaction logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.transactionSavedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
