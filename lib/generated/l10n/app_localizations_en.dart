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
  String get recentBudget => 'Recent Budget';

  @override
  String get recentTransactions => 'Recent Transactions';

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
}
