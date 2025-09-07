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
}
