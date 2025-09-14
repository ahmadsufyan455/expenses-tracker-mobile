import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_button.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_text_form_field.dart';
import 'package:flutter/material.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key, this.category, this.isEdit = false});

  final CategoryDto? category;
  final bool isEdit;

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  IconData _selectedIcon = Icons.category;
  Color _selectedColor = AppColors.primary;
  bool _isLoading = false;

  // Predefined icons for categories
  final List<IconData> _categoryIcons = [
    Icons.category,
    Icons.restaurant,
    Icons.directions_car,
    Icons.shopping_bag,
    Icons.movie,
    Icons.receipt_long,
    Icons.local_hospital,
    Icons.school,
    Icons.home,
    Icons.fitness_center,
    Icons.phone,
    Icons.computer,
    Icons.pets,
    Icons.flight,
    Icons.coffee,
    Icons.sports_soccer,
    Icons.music_note,
    Icons.book,
    Icons.brush,
    Icons.work,
  ];

  // Predefined colors for categories
  final List<Color> _categoryColors = [
    AppColors.primary,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.blueGrey,
  ];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.category != null) {
      _nameController.text = widget.category!.name;
      // For now, use default icon and color
      // TODO: Add icon and color to CategoryDto
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit
            ? context.l10n.editCategory
            : context.l10n.addCategory),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Category Preview
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _selectedColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: _selectedColor, width: 2),
                  ),
                  child: Icon(
                    _selectedIcon,
                    size: 40,
                    color: _selectedColor,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceXL),

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

              // Icon Selection
              Text(
                context.l10n.chooseIcon,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1,
                    crossAxisSpacing: AppDimensions.spaceS,
                    mainAxisSpacing: AppDimensions.spaceS,
                  ),
                  itemCount: _categoryIcons.length,
                  itemBuilder: (context, index) {
                    final icon = _categoryIcons[index];
                    final isSelected = _selectedIcon == icon;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = icon;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _selectedColor.withValues(alpha: 0.1)
                              : Theme.of(context).colorScheme.surface,
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusS),
                          border: Border.all(
                            color: isSelected
                                ? _selectedColor
                                : Theme.of(context).colorScheme.outline,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected
                              ? _selectedColor
                              : Theme.of(context).colorScheme.onSurface,
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppDimensions.spaceXL),

              // Color Selection
              Text(
                context.l10n.chooseColor,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoryColors.length,
                  itemBuilder: (context, index) {
                    final color = _categoryColors[index];
                    final isSelected = _selectedColor == color;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(
                            right: AppDimensions.spaceM),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 3)
                              : null,
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppDimensions.spaceXXL),

              // Save Button
              GlobalButton(
                onPressed: _saveCategory,
                text: widget.isEdit ? context.l10n.updateCategory : context.l10n.addCategory,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // TODO: Implement save functionality with BLoC
      // For now, just show success message and go back
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.isEdit
                  ? context.l10n.categoryUpdatedSuccessfully
                  : context.l10n.categoryAddedSuccessfully),
              backgroundColor: Colors.green,
            ),
          );
        }
      });
    }
  }
}