class AppConstants {
  // App Info
  static const String appName = 'CifarX Task';
  static const String appVersion = '1.0.0';

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 100;

  // Cache
  static const Duration cacheExpiry = Duration(minutes: 30);
  static const Duration longCacheExpiry = Duration(hours: 24);

  // Network
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 30);

  // Debounce
  static const Duration searchDebounce = Duration(milliseconds: 500);

  // Animation
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Layout
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 8.0;
  static const double cardElevation = 2.0;

  // Grid
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.75;
  static const double gridSpacing = 12.0;
}
