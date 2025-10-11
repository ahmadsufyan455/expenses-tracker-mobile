import 'package:expense_tracker_mobile/core/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');
  await configureDependencies();

  if (kReleaseMode && (dotenv.env['SENTRY_DSN']?.isNotEmpty ?? false)) {
    await SentryFlutter.init((options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
      options.environment = 'production';
      options.enableAutoSessionTracking = true;
      options.tracesSampleRate = 0.2;
    }, appRunner: () => runApp(const ExpenseTrackerApp()));
  } else {
    runApp(const ExpenseTrackerApp());
  }
}
