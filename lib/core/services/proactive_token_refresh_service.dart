import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../services/auth_service.dart';

@singleton
class ProactiveTokenRefreshService {
  final AuthService _authService;
  Timer? _refreshTimer;
  final Logger _logger = Logger();
  ProactiveTokenRefreshService(this._authService);

  // Start proactive token refresh checking
  void startProactiveRefresh() {
    // Check every 1 minute if token needs refresh
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) async {
        await _checkAndRefreshToken();
      },
    );
    _logger.i('Proactive token refresh started');
  }

  // Stop proactive token refresh
  void stopProactiveRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  // Check if token needs refresh and refresh if necessary
  Future<void> _checkAndRefreshToken() async {
    try {
      final shouldRefresh = await _authService.shouldRefreshToken();
      if (shouldRefresh) {
        print('Proactively refreshing token...');
        final refreshed = await _authService.refreshToken();
        if (refreshed) {
          print('Token refreshed successfully');
        } else {
          print('Token refresh failed - may need to re-authenticate');
        }
      }
    } catch (e) {
      print('Proactive token refresh error: $e');
    }
  }

  // Manual token refresh trigger
  Future<bool> manualRefresh() async {
    return await _authService.refreshToken();
  }

  // Check if user is logged in and start refresh if needed
  Future<void> initializeForLoggedInUser() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      startProactiveRefresh();
    }
  }

  // Stop refresh on logout
  void onUserLogout() {
    stopProactiveRefresh();
  }
}
