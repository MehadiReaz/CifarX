import 'package:cifarx/core/error/failures.dart';
import 'package:cifarx/core/api/exceptions/api_exception.dart';
import 'package:cifarx/core/api/exceptions/connection_exception.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  static final Logger _logger = Logger();

  static Failure mapExceptionToFailure(dynamic exception) {
    _logger.e('Error occurred: $exception');

    if (exception is ApiException) {
      if (exception.statusCode != null) {
        switch (exception.statusCode) {
          case 400:
            return ValidationFailure(exception.message);
          case 401:
            return const ServerFailure(
              'Authentication failed',
              statusCode: 401,
            );
          case 403:
            return const ServerFailure('Access denied', statusCode: 403);
          case 404:
            return const ServerFailure('Resource not found', statusCode: 404);
          case 500:
            return const ServerFailure(
              'Internal server error',
              statusCode: 500,
            );
          default:
            return ServerFailure(
              exception.message,
              statusCode: exception.statusCode,
            );
        }
      }
      return ServerFailure(exception.message);
    }

    if (exception is ConnectionException) {
      return NetworkFailure(exception.message);
    }

    // Handle other common exceptions
    if (exception.toString().contains('SocketException') ||
        exception.toString().contains('HandshakeException')) {
      return const NetworkFailure('No internet connection');
    }

    if (exception.toString().contains('FormatException')) {
      return const ValidationFailure('Invalid data format');
    }

    return UnknownFailure(exception.toString());
  }

  static String getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return failure.message;
      case NetworkFailure _:
        return 'Please check your internet connection';
      case CacheFailure _:
        return 'Failed to load cached data';
      case ValidationFailure _:
        return failure.message;
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
