import 'package:expense_tracker_mobile/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');
  await configureDependencies();
  await SentryFlutter.init((options) {
    options.dsn = dotenv.env['SENTRY_DSN'];
  }, appRunner: () => runApp(const ExpenseTrackerApp()));
}
