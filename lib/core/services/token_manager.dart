import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../storage/token_storage_service.dart';
import '../../features/auth/domain/repository/auth_repository.dart';

@singleton
class TokenManager {
  final TokenStorageService _tokenStorageService;
  final AuthRepository _authRepository;

  TokenManager(this._tokenStorageService, this._authRepository);

  // Check if token is expired or about to expire
  bool _isTokenExpired(String token, {int bufferMinutes = 2}) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded) as Map<String, dynamic>;

      final exp = payloadMap['exp'] as int?;
      if (exp == null) return true;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final bufferTime = DateTime.now().add(Duration(minutes: bufferMinutes));

      return expiryDate.isBefore(bufferTime);
    } catch (e) {
      // If we can't decode the token, consider it expired
      return true;
    }
  }

  // Get token expiry date
  DateTime? _getTokenExpiry(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(decoded) as Map<String, dynamic>;

      final exp = payloadMap['exp'] as int?;
      if (exp == null) return null;

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    } catch (e) {
      return null;
    }
  }

  // Get a valid access token, refreshing if necessary
  Future<String?> getValidAccessToken() async {
    final currentToken = await _tokenStorageService.getAccessToken();
    if (currentToken == null) return null;

    // Check if token is expired or about to expire
    if (_isTokenExpired(currentToken)) {
      // Try to refresh the token
      final refreshed = await _refreshAccessToken();
      if (refreshed) {
        return await _tokenStorageService.getAccessToken();
      } else {
        // Refresh failed, return null (will trigger logout)
        return null;
      }
    }

    return currentToken;
  }

  // Refresh the access token using refresh token
  Future<bool> _refreshAccessToken() async {
    final refreshToken = await _tokenStorageService.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      // Use the repository to refresh tokens
      final result = await _authRepository.refreshToken(refreshToken);

      return result.fold(
        (failure) {
          print('Token refresh failed: ${failure.message}');
          return false;
        },
        (user) async {
          // Save new tokens
          await _tokenStorageService.saveTokens(
            accessToken: user.accessToken,
            refreshToken: user.refreshToken,
          );
          return true;
        },
      );
    } catch (e) {
      print('Token refresh failed: $e');
      return false;
    }
  }

  // Force refresh token (called manually or from interceptor)
  Future<bool> refreshToken() async {
    return await _refreshAccessToken();
  }

  // Check if access token needs refresh (for proactive refresh)
  Future<bool> shouldRefreshToken() async {
    final token = await _tokenStorageService.getAccessToken();
    if (token == null) return false;
    return _isTokenExpired(token,
        bufferMinutes: 5); // 5 minutes buffer for proactive refresh
  }

  // Get token information for debugging/display
  Future<Map<String, dynamic>?> getTokenInfo() async {
    final token = await _tokenStorageService.getAccessToken();
    if (token == null) return null;

    try {
      final expiry = _getTokenExpiry(token);
      final isExpired = _isTokenExpired(token);

      return {
        'isExpired': isExpired,
        'expiryDate': expiry?.toIso8601String(),
        'timeUntilExpiry': expiry?.difference(DateTime.now()).inMinutes,
      };
    } catch (e) {
      return null;
    }
  }

  // Clear tokens (for logout)
  Future<void> clearTokens() async {
    await _tokenStorageService.clearAuthData();
  }

  // Update stored user with new tokens after refresh
  Future<void> updateUserTokens(String accessToken, String refreshToken) async {
    await _tokenStorageService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
