import 'package:equatable/equatable.dart';

/// Abstract base class for all failures
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final String? errorCode;

  const Failure({required this.message, this.statusCode, this.errorCode});

  @override
  List<Object?> get props => [message, statusCode, errorCode];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
    super.errorCode,
  });
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.statusCode,
    super.errorCode,
  });
}

/// Authentication-related failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.statusCode,
    super.errorCode,
  });
}

/// Validation-related failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.statusCode,
    super.errorCode,
  });
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.statusCode,
    super.errorCode,
  });
}

/// Unknown/Generic failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.statusCode,
    super.errorCode,
  });
}

/// Timeout failures
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Request timeout',
    super.statusCode,
    super.errorCode,
  });
}

/// No internet connection failures
class NoInternetFailure extends Failure {
  const NoInternetFailure({
    super.message = 'No internet connection',
    super.statusCode,
    super.errorCode,
  });
}
