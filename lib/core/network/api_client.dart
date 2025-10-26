import 'package:cifarx/core/constants/api_constants.dart';
import 'package:cifarx/core/utils/logger.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (obj) => AppLogger.log(obj.toString()),
    ));

    // Token Interceptor Example
    // dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    //   options.headers['Authorization'] = 'Bearer ${EnvConfig.token}';
    //   return handler.next(options);
    // }));

    return dio;
  }
}
