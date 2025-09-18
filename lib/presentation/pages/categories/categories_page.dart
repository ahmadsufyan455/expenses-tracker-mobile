import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/domain/dto/category_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/categories/bloc/category_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/category/add_category_bottom_sheet.dart';
import 'package:expense_tracker_mobile/presentation/widgets/category/category_item.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late CategoryBloc _bloc;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<CategoryBloc>()..add(GetCategoryEvent());
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  Future<void> _onRefresh() async {
    _bloc.add(GetCategoryEvent());
  }

  List<CategoryDto> _filterCategories(List<CategoryDto> categories) {
    if (_searchQuery.isEmpty) return categories;
    return categories.where((category) => category.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.categories), elevation: 0),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: context.l10n.searchCategories,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ),

          // Categories List
          Expanded(
            child: BlocConsumer<CategoryBloc, CategoryState>(
              bloc: _bloc,
              listener: (context, state) {
                _handleCategoryState(state);
                _handleDeleteCategoryState(state);
              },
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CategoryLoaded) {
                  final filteredCategories = _filterCategories(state.categories);

                  if (filteredCategories.isEmpty) {
                    return _buildEmptyState();
                  }

                  return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final category = filteredCategories[index];
                        return CategoryItem(
                          category: category,
                          onTap: () async {
                            final shouldRefresh = await _editCategory(category);

                            if (shouldRefresh == true) {
                              _bloc.add(GetCategoryEvent());
                            }
                          },
                          onDelete: () async {
                            final shouldRefresh = await _deleteCategory(category);

                            if (shouldRefresh == true) {
                              _bloc.add(GetCategoryEvent());
                            }
                          },
                        );
                      },
                    ),
                  );
                }

                return _buildEmptyState();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: AppDimensions.paddingAllL,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.category_outlined, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: AppDimensions.spaceM),
            Text(
              _searchQuery.isEmpty ? context.l10n.noCategoriesYet : context.l10n.noCategoriesFound,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              _searchQuery.isEmpty ? context.l10n.addFirstCategory : context.l10n.tryDifferentSearch,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            if (_searchQuery.isEmpty) ...[
              const SizedBox(height: AppDimensions.spaceL),
              ElevatedButton.icon(
                onPressed: _addCategory,
                icon: const Icon(Icons.add),
                label: Text(context.l10n.addCategory),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _addCategory() async {
    final shouldRefresh = await AddCategoryBottomSheet.show(context);

    if (shouldRefresh == true) {
      _bloc.add(GetCategoryEvent());
    }
  }

  Future<bool?> _editCategory(CategoryDto category) {
    return AddCategoryBottomSheet.show(context, category: category, isEdit: true);
  }

  Future<bool?> _deleteCategory(CategoryDto category) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteCategory),
        content: Text(context.l10n.deleteCategoryConfirmation),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.l10n.cancel)),
          TextButton(
            onPressed: () {
              _bloc.add(DeleteCategoryEvent(id: category.id));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }

  void _handleCategoryState(CategoryState state) {
    if (state is CategoryError) {
      ErrorDialog.show(context, state.failure);
    }
  }

  void _handleDeleteCategoryState(CategoryState state) {
    if (state is DeleteCategorySuccess) {
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.categoryDeletedSuccessfully), backgroundColor: Colors.green));
    } else if (state is DeleteCategoryError) {
      Navigator.of(context).pop(true);
      ErrorDialog.show(context, state.failure);
    }
  }
}
