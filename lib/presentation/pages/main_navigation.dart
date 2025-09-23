import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/presentation/pages/budgets/budget_page.dart';
import 'package:expense_tracker_mobile/presentation/pages/categories/categories_page.dart';
import 'package:expense_tracker_mobile/presentation/pages/home/home_page.dart';
import 'package:expense_tracker_mobile/presentation/pages/profile/profile_page.dart';
import 'package:expense_tracker_mobile/presentation/pages/transactions/transactions_page.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const HomePage(),
    const BudgetPage(),
    const TransactionsPage(),
    const CategoriesPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Container(key: ValueKey<int>(_currentIndex), child: _pages[_currentIndex]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), offset: const Offset(0, -1), blurRadius: 8),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildNavItem(Icons.home_outlined, Icons.home, context.l10n.home, 0)),
                Expanded(child: _buildNavItem(Icons.pie_chart_outline, Icons.pie_chart, context.l10n.budget, 1)),
                Expanded(
                  child: _buildNavItem(Icons.receipt_long_outlined, Icons.receipt_long, context.l10n.transactions, 2),
                ),
                Expanded(child: _buildNavItem(Icons.category_outlined, Icons.category, context.l10n.categories, 3)),
                Expanded(child: _buildNavItem(Icons.person_outline, Icons.person, context.l10n.profile, 4)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
