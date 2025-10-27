import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:cifarx/core/api/interceptors/auth_interceptor.dart';
import 'package:cifarx/core/api/interceptors/logging_interceptor.dart';
import 'package:cifarx/core/api/interceptors/connectivity_interceptor.dart';
import 'package:cifarx/core/api/exceptions/api_exception.dart';
import 'package:cifarx/core/api/exceptions/connection_exception.dart';
import 'package:cifarx/core/api/api_endpoints.dart';

@singleton
class ApiClient {
  late final Dio _dio;
  final AuthInterceptor _authInterceptor;

  ApiClient(this._authInterceptor) {
    _initialize();
  }

  void _initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll([
      ConnectivityInterceptor(),
      _authInterceptor,
      LoggingInterceptor(),
    ]);
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const ConnectionException('Connection timeout');
        case DioExceptionType.connectionError:
          return const ConnectionException('No internet connection');
        case DioExceptionType.badResponse:
          return ApiException.fromResponse(
            statusCode: error.response?.statusCode ?? 0,
            message:
                error.response?.data?['message'] ??
                error.message ??
                'Unknown error',
            data: error.response?.data,
          );
        case DioExceptionType.cancel:
          return const ApiException(message: 'Request cancelled');
        case DioExceptionType.badCertificate:
          return const ApiException(message: 'Bad certificate');
        case DioExceptionType.unknown:
          return ApiException(message: error.message ?? 'Unknown error');
      }
    }
    return ApiException(message: error.toString());
  }
}
