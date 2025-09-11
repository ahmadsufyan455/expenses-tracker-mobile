import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:network_logger/network_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DiModule {
  @lazySingleton
  Dio dio() => Dio()..interceptors.add(DioNetworkLogger());

  @Named('baseUrl')
  String baseUrl() => dotenv.env['BASE_URL'] ?? '';

  @preResolve
  @lazySingleton
  Future<SharedPreferences> sharedPreferences() => SharedPreferences.getInstance();
}
