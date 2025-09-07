import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:network_logger/network_logger.dart';

@module
abstract class DiModule {
  @lazySingleton
  Dio dio() => Dio()..interceptors.add(DioNetworkLogger());

  @Named('baseUrl')
  String baseUrl() => dotenv.env['BASE_URL'] ?? '';
}
