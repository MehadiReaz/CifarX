import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class TokenStorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';
  static const String _firstNameKey = 'first_name';
  static const String _lastNameKey = 'last_name';
  static const String _genderKey = 'gender';
  static const String _imageKey = 'image';

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Token operations
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<bool> hasValidTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return accessToken != null && refreshToken != null;
  }

  // User data operations
  Future<void> saveUserData({
    required int userId,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required String image,
  }) async {
    await _storage.write(key: _userIdKey, value: userId.toString());
    await _storage.write(key: _usernameKey, value: username);
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _firstNameKey, value: firstName);
    await _storage.write(key: _lastNameKey, value: lastName);
    await _storage.write(key: _genderKey, value: gender);
    await _storage.write(key: _imageKey, value: image);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final userId = await _storage.read(key: _userIdKey);
    if (userId == null) return null;

    return {
      'id': int.parse(userId),
      'username': await _storage.read(key: _usernameKey),
      'email': await _storage.read(key: _emailKey),
      'firstName': await _storage.read(key: _firstNameKey),
      'lastName': await _storage.read(key: _lastNameKey),
      'gender': await _storage.read(key: _genderKey),
      'image': await _storage.read(key: _imageKey),
    };
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Clear only auth data, keep other app data
  Future<void> clearAuthData() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _userIdKey);
    await _storage.delete(key: _usernameKey);
    await _storage.delete(key: _emailKey);
    await _storage.delete(key: _firstNameKey);
    await _storage.delete(key: _lastNameKey);
    await _storage.delete(key: _genderKey);
    await _storage.delete(key: _imageKey);
  }
}
