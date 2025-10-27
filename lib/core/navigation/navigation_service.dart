import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  // Navigation methods
  static void push(String path, {Object? extra}) {
    GoRouter.of(context).push(path, extra: extra);
  }

  static void pushReplacement(String path, {Object? extra}) {
    GoRouter.of(context).pushReplacement(path, extra: extra);
  }

  static void go(String path, {Object? extra}) {
    GoRouter.of(context).go(path, extra: extra);
  }

  static void pop<T extends Object?>([T? result]) {
    GoRouter.of(context).pop(result);
  }

  static void popUntil(String path) {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    GoRouter.of(context).go(path);
  }

  // Specific navigation methods
  static void goToHome() {
    go('/');
  }

  static void goToProducts() {
    go('/products');
  }

  static void goToProductDetail(String productId) {
    push('/product/$productId');
  }

  static void goToSearch({String? query}) {
    final path = query != null ? '/search?q=$query' : '/search';
    push(path);
  }

  static void goToProfile() {
    push('/profile');
  }

  static void goToSettings() {
    push('/settings');
  }

  // Utility methods
  static bool canPop() {
    return GoRouter.of(context).canPop();
  }

  static String getCurrentLocation() {
    return GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .uri
        .toString();
  }

  static void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  static Future<T?> showCustomDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }
}
