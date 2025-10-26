import 'package:logger/logger.dart';

/// A centralized logging utility that supports multiple log levels.
/// Wraps the `logger` package for consistent logging across the app.
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,       // No stack trace
      errorMethodCount: 5,  // Show stack trace for errors
      lineLength: 80,       // Width of output
      colors: true,         // Colorful logs in debug console
      printEmojis: true,    // Emojis for log levels
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// General log output (use this for non-critical info)
  static void log(dynamic message, {String? tag}) {
    _logger.i('${_prefix(tag)}$message');
  }

  /// Debug logs (used during development)
  static void debug(dynamic message, {String? tag}) {
    _logger.d('${_prefix(tag)}$message');
  }

  /// Warnings (for potential issues)
  static void warn(dynamic message, {String? tag}) {
    _logger.w('${_prefix(tag)}$message');
  }

  /// Errors (with optional stack trace)
  static void error(dynamic message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _logger.e('${_prefix(tag)}$message', error: error, stackTrace: stackTrace);
  }

  /// API logs (for network-related info)
  static void api(String endpoint, dynamic response, {int? statusCode}) {
    _logger.i('[API] $endpoint → Status: $statusCode\n$response');
  }

  /// Internal prefix formatter
  static String _prefix(String? tag) => tag != null ? '[$tag] ' : '';
}
