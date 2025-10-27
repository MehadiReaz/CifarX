class ApiEndpoints {
  static const String baseUrl = 'https://dummyjson.com';

  // Products
  static const String products = '/products';
  static const String searchProducts = '/products/search';
  static String productById(int id) => '/products/$id';

  // Auth endpoints (for future use)
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';

  // User endpoints (for future use)
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
}
