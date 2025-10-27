import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../services/auth_service.dart';
import '../../services/token_manager.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final AuthService _authService;
  final TokenManager _tokenManager;

  AuthInterceptor(this._authService, this._tokenManager);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for certain endpoints
    if (_shouldSkipAuth(options.path)) {
      return handler.next(options);
    }

    // Get valid access token (will refresh if needed)
    final authHeader = await _authService.getAuthorizationHeader();

    // Add authorization header if token exists
    if (authHeader != null) {
      options.headers['Authorization'] = authHeader;
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 unauthorized and 403 forbidden errors
    if ((err.response?.statusCode == 401 || err.response?.statusCode == 403) &&
        !_shouldSkipAuth(err.requestOptions.path)) {
      // For 403, directly logout as it's forbidden
      if (err.response?.statusCode == 403) {
        await _authService.logout();
        print('403 Forbidden - user needs to re-authenticate');
      } else {
        // For 401, try to refresh the token
        final refreshSuccess = await _tokenManager.refreshToken();

        if (refreshSuccess) {
          // Retry the original request with new token
          try {
            final newAuthHeader = await _authService.getAuthorizationHeader();
            if (newAuthHeader != null) {
              err.requestOptions.headers['Authorization'] = newAuthHeader;

              // Retry the request
              final response = await Dio().fetch(err.requestOptions);
              return handler.resolve(response);
            }
          } catch (retryError) {
            // If retry fails, continue with original error
          }
        } else {
          // Refresh failed - token might be expired, clear auth data
          await _authService.logout();
          // You might want to trigger a logout event here
          print('Token refresh failed - user needs to re-authenticate');
        }
      }
    }

    handler.next(err);
  }

  // Check if authentication should be skipped for this endpoint
  bool _shouldSkipAuth(String path) {
    final skipPaths = [
      '/auth/login',
      '/auth/refresh',
      '/auth/register',
    ];

    return skipPaths.any((skipPath) => path.contains(skipPath));
  }
}
