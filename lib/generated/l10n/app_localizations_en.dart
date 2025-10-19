// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTagline => 'Your Smart Financial Companion';

  @override
  String get appSubtitle => 'Track • Analyze • Save';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get loginSubtitle => 'Sign in to continue managing your expenses';

  @override
  String get createAccount => 'Create Account';

  @override
  String get registerSubtitle =>
      'Join us to start tracking your expenses smartly';

  @override
  String get email => 'Email Address';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get createPasswordHint => 'Create a strong password';

  @override
  String get firstName => 'First Name';

  @override
  String get firstNameHint => 'Enter first name';

  @override
  String get lastName => 'Last Name';

  @override
  String get lastNameHint => 'Enter last name';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get createAccountButton => 'Create Account';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get agreeToTerms => 'I agree to the ';

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get and => ' and ';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get loginSuccessful => 'Login successful!';

  @override
  String get accountCreatedSuccessfully => 'Account created successfully!';

  @override
  String get pleaseAcceptTerms => 'Please accept the terms and conditions';

  @override
  String get or => 'or';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String passwordTooShort(int minLength) {
    return 'Password must be at least $minLength characters';
  }

  @override
  String fieldRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String fieldTooShort(String fieldName, int minLength) {
    return '$fieldName must be at least $minLength characters';
  }

  @override
  String nameLettersOnly(String fieldName) {
    return '$fieldName can only contain letters';
  }

  @override
  String numberRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String numberInvalid(String fieldName) {
    return '$fieldName must be a valid number';
  }

  @override
  String numberMustBePositive(String fieldName) {
    return '$fieldName must be greater than 0';
  }

  @override
  String get goodMorning => 'Good Morning!';

  @override
  String get goodAfternoon => 'Good Afternoon!';

  @override
  String get goodEvening => 'Good Evening!';

  @override
  String get overview => 'Overview';

  @override
  String get totalIncome => 'Total Income';

  @override
  String get totalExpense => 'Total Expense';

  @override
  String get netBalance => 'Net Balance';

  @override
  String get savingsRate => 'Savings Rate';

  @override
  String get recentBudget => 'Recent Budget';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get topExpenses => 'Top Expenses';

  @override
  String get ofTotalExpenses => 'of total expenses';

  @override
  String get overBudget => 'Over budget';

  @override
  String get withinBudget => 'Within budget';

  @override
  String get viewAll => 'View All';

  @override
  String get monthly => 'Monthly';

  @override
  String get weekly => 'Weekly';

  @override
  String get yearly => 'Yearly';

  @override
  String get used => 'used';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get home => 'Home';

  @override
  String get transactions => 'Transactions';

  @override
  String get budget => 'Budget';

  @override
  String get profile => 'Profile';

  @override
  String get manageTransactions => 'Manage your income and expenses';

  @override
  String get budgetManagement => 'Budget Management';

  @override
  String get planSpending => 'Plan and track your spending';

  @override
  String get welcomeUser => 'Welcome User!';

  @override
  String get manageAccount => 'Manage your account and preferences';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get updatePersonalInfo => 'Update your personal information';

  @override
  String get notifications => 'Notifications';

  @override
  String get manageNotifications => 'Manage your notification preferences';

  @override
  String get security => 'Security';

  @override
  String get changePassword => 'Change password and security settings';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get getHelp => 'Get help and contact support';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get ok => 'OK';

  @override
  String get addTransaction => 'Add Transaction';

  @override
  String get updateTransaction => 'Update Transaction';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';

  @override
  String get amount => 'Amount';

  @override
  String get category => 'Category';

  @override
  String get description => 'Description';

  @override
  String get descriptionOptional => 'Description (Optional)';

  @override
  String get saveTransaction => 'Save Transaction';

  @override
  String get pleaseEnterAmount => 'Please enter amount';

  @override
  String get pleaseEnterValidAmount => 'Please enter valid amount';

  @override
  String get pleaseSelectCategory => 'Please select a category';

  @override
  String get transactionSavedSuccessfully => 'Transaction saved successfully!';

  @override
  String get transactionUpdatedSuccessfully =>
      'Transaction updated successfully!';

  @override
  String get foodDining => 'Food & Dining';

  @override
  String get transportation => 'Transportation';

  @override
  String get shopping => 'Shopping';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get billsUtilities => 'Bills & Utilities';

  @override
  String get healthcare => 'Healthcare';

  @override
  String get education => 'Education';

  @override
  String get others => 'Others';

  @override
  String get salary => 'Salary';

  @override
  String get business => 'Business';

  @override
  String get investment => 'Investment';

  @override
  String get gift => 'Gift';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get pleaseSelectPaymentMethod => 'Please select a payment method';

  @override
  String get cash => 'Cash';

  @override
  String get creditCard => 'Credit Card';

  @override
  String get bankTransfer => 'Bank Transfer';

  @override
  String get digitalWallet => 'Digital Wallet';

  @override
  String get date => 'Date';

  @override
  String get type => 'Type';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get transactionDetails => 'Transaction Details';

  @override
  String get past => 'Past';

  @override
  String get deleteTransaction => 'Delete Transaction';

  @override
  String get deleteTransactionConfirmation =>
      'Are you sure you want to delete this transaction? This action cannot be undone.';

  @override
  String get transactionDeletedSuccessfully =>
      'Transaction deleted successfully';

  @override
  String get categories => 'Categories';

  @override
  String get manageCategories => 'Manage Categories';

  @override
  String get manageCategoriesSubtitle =>
      'Add, edit, and organize your categories';

  @override
  String get addCategory => 'Add Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get categoryName => 'Category Name';

  @override
  String get chooseIcon => 'Choose Icon';

  @override
  String get chooseColor => 'Choose Color';

  @override
  String get addNewCategory => 'Add New Category';

  @override
  String get updateCategory => 'Update Category';

  @override
  String get categoryAddedSuccessfully => 'Category added successfully!';

  @override
  String get categoryUpdatedSuccessfully => 'Category updated successfully!';

  @override
  String get categoryDeletedSuccessfully => 'Category deleted successfully!';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String get deleteCategoryConfirmation =>
      'Are you sure you want to delete this category?';

  @override
  String get searchCategories => 'Search categories...';

  @override
  String get noCategoriesYet => 'No categories yet';

  @override
  String get noCategoriesFound => 'No categories found';

  @override
  String get addFirstCategory => 'Add your first category to get started';

  @override
  String get tryDifferentSearch => 'Try a different search term';

  @override
  String usedInTransactions(int count) {
    return 'Used in $count transactions';
  }

  @override
  String get categoryNameRequired => 'Please enter category name';

  @override
  String get categoryNameTooShort =>
      'Category name must be at least 2 characters';

  @override
  String get addNewCategoryTooltip => 'Add new category';

  @override
  String get budgets => 'Budgets';

  @override
  String get manageBudgets => 'Manage Budgets';

  @override
  String get manageBudgetsSubtitle => 'Plan and track your spending limits';

  @override
  String get addBudget => 'Add Budget';

  @override
  String get editBudget => 'Edit Budget';

  @override
  String get deleteBudget => 'Delete Budget';

  @override
  String get budgetAmount => 'Budget Amount';

  @override
  String get dateRange => 'Date Range';

  @override
  String get selectDateRange => 'Select Date Range';

  @override
  String get budgetPeriod => 'Budget Period';

  @override
  String get createBudget => 'Create Budget';

  @override
  String get updateBudget => 'Update Budget';

  @override
  String get saveBudget => 'Save Budget';

  @override
  String get budgetAddedSuccessfully => 'Budget added successfully!';

  @override
  String get budgetUpdatedSuccessfully => 'Budget updated successfully!';

  @override
  String get budgetDeletedSuccessfully => 'Budget deleted successfully!';

  @override
  String get deleteBudgetConfirmation =>
      'Are you sure you want to delete this budget?';

  @override
  String get noBudgetsYet => 'No budgets yet';

  @override
  String get addFirstBudget => 'Add your first budget to get started';

  @override
  String get pleaseEnterBudgetAmount => 'Please enter budget amount';

  @override
  String get pleaseEnterValidBudgetAmount => 'Please enter valid budget amount';

  @override
  String get pleaseSelectDateRange => 'Please select a date range';

  @override
  String budgetForCategory(String categoryName) {
    return 'Budget for $categoryName';
  }

  @override
  String monthYear(String month, String year) {
    return '$month $year';
  }

  @override
  String get addNewBudgetTooltip => 'Add new budget';

  @override
  String get budgetStatusActive => 'Active';

  @override
  String get budgetStatusExpired => 'Expired';

  @override
  String get budgetStatusUpcoming => 'Upcoming';

  @override
  String get budgetEndingSoon => 'Ending Soon';

  @override
  String daysRemaining(int days) {
    return 'Days Remaining';
  }

  @override
  String get enablePrediction => 'Enable Prediction';

  @override
  String get predictionType => 'Prediction Type';

  @override
  String get predictionDaysCount => 'Custom Days Count';

  @override
  String get daily => 'Daily';

  @override
  String get weekends => 'Weekends';

  @override
  String get weekdays => 'Weekdays';

  @override
  String get custom => 'Custom';

  @override
  String get dailyAllowance => 'Daily Allowance';

  @override
  String get spentAmount => 'Spent';

  @override
  String get remainingBudget => 'Remaining';

  @override
  String get predictionTitle => 'Budget Prediction';

  @override
  String get pleaseEnterPredictionDays => 'Please enter custom days count';

  @override
  String get pleaseEnterValidPredictionDays =>
      'Please enter valid days count (1-365)';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get updateProfile => 'Update Profile';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get changePasswordButton => 'Change Password';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully!';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully!';

  @override
  String get accountDeletedSuccessfully => 'Account deleted successfully!';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountWarning =>
      'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.';

  @override
  String get currentPasswordRequired => 'Current password is required';

  @override
  String get newPasswordRequired => 'New password is required';

  @override
  String get passwordsDontMatch => 'Passwords don\'t match';

  @override
  String newPasswordTooShort(int minLength) {
    return 'New password must be at least $minLength characters';
  }

  @override
  String get enterCurrentPassword => 'Enter your current password';

  @override
  String get enterNewPassword => 'Enter your new password';

  @override
  String get confirmYourNewPassword => 'Confirm your new password';

  @override
  String get profileInformation => 'Profile Information';

  @override
  String get accountDeletion => 'Account Deletion';

  @override
  String get dangerZone => 'Danger Zone';

  @override
  String get deleteAccountDescription =>
      'Permanently delete your account and all associated data';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get noBudgetData => 'No budget data available';

  @override
  String get totalIncomeChart => 'Total Income';

  @override
  String get totalExpensesChart => 'Total Expenses';

  @override
  String get todayExpenses => 'Today Expenses';

  @override
  String get netBalanceChart => 'Net Balance';

  @override
  String get savingsRateGauge => 'Savings Rate';

  @override
  String get expenses => 'Expenses';

  @override
  String get net => 'Net';

  @override
  String get savings => 'Savings';

  @override
  String get filterByStatus => 'Filter by Status';

  @override
  String get all => 'All';
}
