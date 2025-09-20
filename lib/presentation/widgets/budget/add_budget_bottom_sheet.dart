import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/enums/budget_enums.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/number_utils.dart';
import 'package:expense_tracker_mobile/domain/dto/budget_dto.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/budgets/bloc/budget_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_button.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_dropdown_form_field.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class AddBudgetBottomSheet extends StatefulWidget {
  const AddBudgetBottomSheet({super.key, this.budget, required this.categories});

  final BudgetDto? budget;
  final List<CategoryDto> categories;

  static Future<bool?> show(BuildContext context, {BudgetDto? budget, required List<CategoryDto> categories}) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddBudgetBottomSheet(budget: budget, categories: categories),
    );
  }

  @override
  State<AddBudgetBottomSheet> createState() => _AddBudgetBottomSheetState();
}

class _AddBudgetBottomSheetState extends State<AddBudgetBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _predictionDaysController = TextEditingController();

  late BudgetBloc _bloc;
  CategoryDto? _selectedCategory;
  DateTime? _selectedMonth;
  bool _isLoading = false;
  bool _predictionEnabled = false;
  PredictionType? _selectedPredictionType;
  int? _predictionDaysCount;

  bool get _isUpdate => widget.budget != null;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<BudgetBloc>();
    _initializeData();
  }

  void _initializeData() {
    if (_isUpdate && widget.budget != null) {
      final budget = widget.budget!;
      _selectedCategory = widget.categories.firstWhere(
        (cat) => cat.id == budget.categoryId,
        orElse: () => widget.categories.first,
      );
      _selectedMonth = DateTime.parse(budget.month);
      _amountController.text = NumberUtils.formatWithThousandSeparator(budget.amount);
      _predictionEnabled = budget.predictionEnabled;
      _selectedPredictionType = budget.predictionType;
      _predictionDaysCount = budget.predictionDaysCount;
      if (_predictionDaysCount != null) {
        _predictionDaysController.text = _predictionDaysCount.toString();
      }
    } else {
      // Default to current month for new budgets
      _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _predictionDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusL),
          topRight: Radius.circular(AppDimensions.radiusL),
        ),
      ),
      child: BlocConsumer<BudgetBloc, BudgetState>(
        bloc: _bloc,
        listener: (context, state) {
          _handleBudgetState(state);
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.paddingL,
              right: AppDimensions.paddingL,
              top: AppDimensions.paddingL,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppDimensions.paddingL,
            ),
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
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceL),

                // Title
                Text(
                  _isUpdate ? context.l10n.editBudget : context.l10n.addBudget,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppDimensions.spaceL),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Category Dropdown
                      GlobalDropdownFormField<CategoryDto>(
                        value: _selectedCategory,
                        labelText: context.l10n.category,
                        items: widget.categories
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
                      const SizedBox(height: AppDimensions.spaceM),

                      // Amount Field
                      GlobalTextFormField(
                        controller: _amountController,
                        labelText: context.l10n.budgetAmount,
                        prefixText: 'Rp ',
                        keyboardType: TextInputType.number,
                        inputFormatters: [ThousandSeparatorInputFormatter()],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.pleaseEnterBudgetAmount;
                          }
                          if (!NumberUtils.isValidFormattedNumber(value)) {
                            return context.l10n.pleaseEnterValidBudgetAmount;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.spaceM),

                      // Month Selector
                      InkWell(
                        onTap: _selectMonth,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: context.l10n.budgetMonth,
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(Icons.calendar_today_outlined),
                          ),
                          child: Text(
                            _selectedMonth != null
                                ? DateFormat.yMMMM().format(_selectedMonth!)
                                : context.l10n.selectMonth,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceM),

                      // Prediction Section
                      SwitchListTile(
                        title: Text(context.l10n.enablePrediction),
                        value: _predictionEnabled,
                        onChanged: (value) {
                          setState(() {
                            _predictionEnabled = value;
                            if (!value) {
                              _selectedPredictionType = null;
                              _predictionDaysCount = null;
                              _predictionDaysController.clear();
                            }
                          });
                        },
                      ),

                      if (_predictionEnabled) ...[
                        const SizedBox(height: AppDimensions.spaceM),
                        // Prediction Type Dropdown
                        GlobalDropdownFormField<PredictionType>(
                          value: _selectedPredictionType,
                          labelText: context.l10n.predictionType,
                          items: PredictionType.values
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Row(
                                    children: [
                                      Icon(type.icon, size: 20),
                                      const SizedBox(width: AppDimensions.spaceS),
                                      Text(type.getDisplayName(context)),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedPredictionType = value;
                              if (value != PredictionType.custom) {
                                _predictionDaysCount = null;
                                _predictionDaysController.clear();
                              }
                            });
                          },
                        ),

                        if (_selectedPredictionType == PredictionType.custom) ...[
                          const SizedBox(height: AppDimensions.spaceM),
                          // Custom Days Count Field
                          GlobalTextFormField(
                            controller: _predictionDaysController,
                            labelText: context.l10n.predictionDaysCount,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (_selectedPredictionType == PredictionType.custom) {
                                if (value == null || value.isEmpty) {
                                  return context.l10n.pleaseEnterPredictionDays;
                                }
                                final days = int.tryParse(value);
                                if (days == null || days < 1 || days > 365) {
                                  return context.l10n.pleaseEnterValidPredictionDays;
                                }
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _predictionDaysCount = int.tryParse(value);
                            },
                          ),
                        ],
                      ],

                      const SizedBox(height: AppDimensions.spaceXL),

                      // Save Button
                      GlobalButton(onPressed: _saveBudget, text: context.l10n.saveBudget, isLoading: _isLoading),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectMonth() async {
    final now = DateTime.now();
    final currentYear = now.year;

    // Show year picker first
    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Year'),
        content: SizedBox(
          width: double.minPositive,
          height: 300,
          child: YearPicker(
            firstDate: DateTime(currentYear - 5),
            lastDate: DateTime(currentYear + 5),
            selectedDate: _selectedMonth ?? now,
            onChanged: (date) => Navigator.pop(context, date.year),
          ),
        ),
      ),
    );

    if (selectedYear == null) return;

    if (!mounted) return;

    // Show month picker
    final selectedMonth = await showDialog<int>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select Month'),
        children: List.generate(12, (index) {
          final month = index + 1;
          final monthName = DateFormat.MMMM().format(DateTime(selectedYear, month));
          return SimpleDialogOption(onPressed: () => Navigator.pop(context, month), child: Text(monthName));
        }),
      ),
    );

    if (selectedMonth != null) {
      setState(() {
        _selectedMonth = DateTime(selectedYear, selectedMonth);
      });
    }
  }

  void _saveBudget() {
    if (_formKey.currentState!.validate()) {
      if (_selectedMonth == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.pleaseSelectMonth), backgroundColor: Colors.red));
        return;
      }

      final amount = NumberUtils.parseFromFormattedString(_amountController.text);
      final monthString = DateFormat('yyyy-MM').format(_selectedMonth!);

      if (_isUpdate) {
        _bloc.add(
          UpdateBudgetEvent(
            id: widget.budget!.id,
            categoryId: _selectedCategory!.id,
            amount: amount,
            month: monthString,
            predictionEnabled: _predictionEnabled,
            predictionType: _selectedPredictionType?.value,
            predictionDaysCount: _predictionDaysCount,
          ),
        );
      } else {
        _bloc.add(
          CreateBudgetEvent(
            categoryId: _selectedCategory!.id,
            amount: amount,
            month: monthString,
            predictionEnabled: _predictionEnabled,
            predictionType: _selectedPredictionType?.value,
            predictionDaysCount: _predictionDaysCount,
          ),
        );
      }
    }
  }

  void _handleBudgetState(BudgetState state) {
    if (state is CreateBudgetLoading || state is UpdateBudgetLoading) {
      setState(() {
        _isLoading = true;
      });
    } else if (state is CreateBudgetSuccess || state is UpdateBudgetSuccess) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop(true);
    } else if (state is CreateBudgetFailure || state is UpdateBudgetFailure) {
      setState(() {
        _isLoading = false;
      });
      final failure = state is CreateBudgetFailure ? state.failure : (state as UpdateBudgetFailure).failure;
      ErrorDialog.show(context, failure);
    }
  }
}
