import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../services/auth_service.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/domain/entities/user.dart';

/// Global utility class to easily access authentication status and user data
/// throughout the app without needing context or BLoC access.
class AuthUtils {
  static final AuthService _authService = getIt<AuthService>();

  /// Check if user is currently logged in
  /// Returns true if user has valid tokens stored
  static Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }

  /// Get the current access token
  /// Returns null if no token is stored
  static Future<String?> getAccessToken() async {
    return await _authService.getAccessToken();
  }

  /// Get the current refresh token
  /// Returns null if no token is stored
  static Future<String?> getRefreshToken() async {
    return await _authService.getRefreshToken();
  }

  /// Get the Authorization header value for API requests
  /// Returns "Bearer {token}" or null if no token exists
  static Future<String?> getAuthorizationHeader() async {
    return await _authService.getAuthorizationHeader();
  }

  /// Get the currently stored user data
  /// Returns null if no user is logged in
  static Future<UserEntity?> getCurrentUser() async {
    return await _authService.getStoredUser();
  }

  /// Logout the current user and clear all stored data
  static Future<void> logout() async {
    await _authService.logout();
  }

  /// Get token information (expiry, validity) for debugging/display
  static Future<Map<String, dynamic>?> getTokenInfo() async {
    return await _authService.getTokenInfo();
  }

  /// Helper method to get current authentication state from BLoC
  /// Requires BuildContext to access the BLoC
  static AuthState getCurrentAuthState(BuildContext context) {
    return context.read<AuthBloc>().state;
  }

  /// Helper method to check if current BLoC state is authenticated
  /// Requires BuildContext to access the BLoC
  static bool isBlocAuthenticated(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    return state is AuthAuthenticated;
  }

  /// Helper method to get user from current BLoC state
  /// Requires BuildContext to access the BLoC
  /// Returns null if not authenticated
  static UserEntity? getBlocUser(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    return state is AuthAuthenticated ? state.user : null;
  }
}

/// Extension on BuildContext for easier access to authentication utilities
extension AuthContextExtension on BuildContext {
  /// Get current authentication state
  AuthState get authState => read<AuthBloc>().state;

  /// Check if user is authenticated in current BLoC state
  bool get isAuthenticated => read<AuthBloc>().state is AuthAuthenticated;

  /// Check if user has skipped authentication
  bool get isAuthSkipped => read<AuthBloc>().state is AuthSkipped;

  /// Get current user from BLoC state (null if not authenticated)
  UserEntity? get currentUser {
    final state = read<AuthBloc>().state;
    return state is AuthAuthenticated ? state.user : null;
  }

  /// Trigger logout event
  void logout() => read<AuthBloc>().add(LogoutEvent());

  /// Trigger authentication status check
  void checkAuthStatus() => read<AuthBloc>().add(CheckAuthStatusEvent());
}
