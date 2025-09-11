import 'package:dio/dio.dart';
import 'package:expense_tracker_mobile/core/interceptors/auth_interceptor.dart';
import 'package:expense_tracker_mobile/core/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:network_logger/network_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DiModule {
  @lazySingleton
  Dio dio(SessionService sessionService, @Named('navigatorKey') GlobalKey<NavigatorState> navigatorKey) {
    final dio = Dio();
    dio.interceptors.addAll([AuthInterceptor(sessionService, navigatorKey), DioNetworkLogger()]);
    return dio;
  }

  @Named('baseUrl')
  String baseUrl() => dotenv.env['BASE_URL'] ?? '';

  @preResolve
  @lazySingleton
  Future<SharedPreferences> sharedPreferences() => SharedPreferences.getInstance();

  @Named('navigatorKey')
  @lazySingleton
  GlobalKey<NavigatorState> navigatorKey() => GlobalKey<NavigatorState>();
}
