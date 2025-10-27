import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log(
      '🚀 REQUEST: ${options.method} ${options.uri}',
      name: 'API_REQUEST',
    );

    if (options.data != null) {
      developer.log(
        'Data: ${options.data}',
        name: 'API_REQUEST',
      );
    }

    if (options.queryParameters.isNotEmpty) {
      developer.log(
        'Query Parameters: ${options.queryParameters}',
        name: 'API_REQUEST',
      );
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log(
      '✅ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
      name: 'API_RESPONSE',
    );

    if (response.data != null) {
      developer.log(
        'Response Data: ${response.data}',
        name: 'API_RESPONSE',
      );
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    developer.log(
      '❌ ERROR: ${err.response?.statusCode} ${err.requestOptions.uri}',
      name: 'API_ERROR',
    );

    if (err.response?.data != null) {
      developer.log(
        'Error Data: ${err.response?.data}',
        name: 'API_ERROR',
      );
    }

    _logger.e('API Error: ${err.message}');
    handler.next(err);
  }
}
