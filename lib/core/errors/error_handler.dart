import 'package:dio/dio.dart';

import 'failure.dart';

/// Utility class to handle and convert exceptions to Failure objects
class ErrorHandler {
  ErrorHandler._();

  /// Convert DioException to appropriate Failure
  static Failure handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();

      case DioExceptionType.connectionError:
        return const NoInternetFailure();

      case DioExceptionType.badResponse:
        return _handleResponseError(error);

      case DioExceptionType.cancel:
        return const UnknownFailure(message: 'Request cancelled');

      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        return UnknownFailure(
          message: error.message ?? 'Unknown error occurred',
        );
    }
  }

  /// Handle HTTP response errors based on status code
  static Failure _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final message =
        _extractErrorMessage(error.response?.data) ??
        error.message ??
        'Server error occurred';

    switch (statusCode) {
      case 400:
        return ValidationFailure(message: message, statusCode: statusCode);

      case 401:
        return AuthFailure(
          message: message.isEmpty ? 'Invalid credentials' : message,
          statusCode: statusCode,
        );

      case 403:
        return AuthFailure(
          message: message.isEmpty ? 'Access forbidden' : message,
          statusCode: statusCode,
        );

      case 404:
        return ServerFailure(
          message: message.isEmpty ? 'Resource not found' : message,
          statusCode: statusCode,
        );

      case 422:
        return ValidationFailure(
          message: message.isEmpty ? 'Validation failed' : message,
          statusCode: statusCode,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          message: message.isEmpty ? 'Server error' : message,
          statusCode: statusCode,
        );

      default:
        return ServerFailure(message: message, statusCode: statusCode);
    }
  }

  /// Extract error message from response data
  static String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      // Try different common error message fields
      return data['message'] as String? ??
          data['error'] as String? ??
          data['detail'] as String? ??
          data['errors']?.toString();
    }

    if (data is String) {
      return data;
    }

    return null;
  }

  /// Convert any exception to Failure
  static Failure handleError(Object error) {
    if (error is DioException) {
      return handleDioError(error);
    }

    return UnknownFailure(message: error.toString());
  }
}
