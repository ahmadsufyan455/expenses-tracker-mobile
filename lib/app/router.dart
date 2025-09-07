import 'package:expense_tracker_mobile/presentation/pages/auth/login/login_page.dart';
import 'package:expense_tracker_mobile/presentation/pages/auth/register/register_page.dart';
import 'package:expense_tracker_mobile/presentation/pages/auth/splash_page.dart';

enum RouteName {
  splash('/splash'),
  login('/login'),
  register('/register');

  final String path;
  const RouteName(this.path);
}

final routes = {
  RouteName.splash.path: (context) => const SplashPage(),
  RouteName.login.path: (context) => const LoginPage(),
  RouteName.register.path: (context) => const RegisterPage(),
};
