import 'package:injectable/injectable.dart';
import '../storage/token_storage_service.dart';
import '../../features/auth/domain/entities/user.dart';
import 'token_manager.dart';

@singleton
class AuthService {
  final TokenStorageService _tokenStorageService;
  final TokenManager _tokenManager;

  AuthService(this._tokenStorageService, this._tokenManager);

  // Get current access token (with automatic refresh if needed)
  Future<String?> getAccessToken() async {
    return await _tokenManager.getValidAccessToken();
  }

  // Get current refresh token
  Future<String?> getRefreshToken() async {
    return await _tokenStorageService.getRefreshToken();
  }

  // Helper method to get Authorization header value (with automatic refresh)
  Future<String?> getAuthorizationHeader() async {
    final token = await getAccessToken();
    return token != null ? 'Bearer $token' : null;
  }

  // Check if user is currently logged in (and tokens are valid)
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }

  // Check if token should be refreshed proactively
  Future<bool> shouldRefreshToken() async {
    return await _tokenManager.shouldRefreshToken();
  }

  // Force refresh token
  Future<bool> refreshToken() async {
    return await _tokenManager.refreshToken();
  }

  // Get token information for debugging
  Future<Map<String, dynamic>?> getTokenInfo() async {
    return await _tokenManager.getTokenInfo();
  }

  // Save user authentication data
  Future<void> saveUserAuth(UserEntity user) async {
    await _tokenStorageService.saveTokens(
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
    );

    await _tokenStorageService.saveUserData(
      userId: user.id,
      username: user.username,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      gender: user.gender,
      image: user.image,
    );
  }

  // Get stored user data if available
  Future<UserEntity?> getStoredUser() async {
    final userData = await _tokenStorageService.getUserData();
    if (userData == null) return null;

    final accessToken = await _tokenStorageService.getAccessToken();
    final refreshToken = await _tokenStorageService.getRefreshToken();

    if (accessToken == null || refreshToken == null) return null;

    return UserEntity(
      id: userData['id'],
      username: userData['username'],
      email: userData['email'],
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      gender: userData['gender'],
      image: userData['image'],
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  // Clear all authentication data
  Future<void> logout() async {
    await _tokenManager.clearTokens();
  }
}
