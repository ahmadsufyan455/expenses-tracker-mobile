import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/categories/bloc/category_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_button.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key, this.category, this.isEdit = false});

  final CategoryDto? category;
  final bool isEdit;

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();

  static Future<bool?> show(BuildContext context, {CategoryDto? category, bool isEdit = false}) {
    return showModalBottomSheet<bool?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCategoryBottomSheet(category: category, isEdit: isEdit),
    );
  }
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  late CategoryBloc _bloc;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<CategoryBloc>();
    if (widget.isEdit && widget.category != null) {
      _nameController.text = widget.category!.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      bloc: _bloc,
      listener: (context, state) {
        _handleCategoryState(state);
        _handleUpdateCategoryState(state);
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radiusL),
              topRight: Radius.circular(AppDimensions.radiusL),
            ),
          ),
          padding: EdgeInsets.only(
            top: AppDimensions.paddingM,
            left: AppDimensions.paddingL,
            right: AppDimensions.paddingL,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppDimensions.paddingL,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              const SizedBox(height: AppDimensions.spaceM),

              // Title
              Text(
                widget.isEdit ? context.l10n.editCategory : context.l10n.addCategory,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spaceL),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Category Name
                    GlobalTextFormField(
                      controller: _nameController,
                      labelText: context.l10n.categoryName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.categoryNameRequired;
                        }
                        if (value.length < 2) {
                          return context.l10n.categoryNameTooShort;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.spaceXL),

                    // Save Button
                    GlobalButton(
                      onPressed: _saveCategory,
                      text: widget.isEdit ? context.l10n.updateCategory : context.l10n.addCategory,
                      isLoading: _isLoading,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      if (widget.isEdit) {
        _bloc.add(UpdateCategoryEvent(id: widget.category!.id, name: _nameController.text));
      } else {
        _bloc.add(CreateCategoryEvent(name: _nameController.text));
      }
    }
  }

  void _handleCategoryState(CategoryState state) {
    if (state is CategoryLoading) {
      _setLoading(true);
    } else if (state is CreateCategorySuccess) {
      _setLoading(false);
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.green));
    } else if (state is CreateCategoryError) {
      _setLoading(false);
      Navigator.of(context).pop();
      ErrorDialog.show(context, state.failure);
    }
  }

  void _handleUpdateCategoryState(CategoryState state) {
    if (state is UpdateCategoryLoading) {
      _setLoading(true);
    } else if (state is UpdateCategorySuccess) {
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.categoryUpdatedSuccessfully), backgroundColor: Colors.green));
    } else if (state is UpdateCategoryError) {
      Navigator.of(context).pop();
      ErrorDialog.show(context, state.failure);
    }
  }

  void _setLoading(bool isLoading) {
    if (mounted) {
      setState(() {
        _isLoading = isLoading;
      });
    }
  }
}
