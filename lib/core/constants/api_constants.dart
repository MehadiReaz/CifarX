class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://dummyjson.com';
  static const String imageBaseUrl = 'https://dummyjson.com';

  // Endpoints

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/auth/profile';
  static const String products = '/products';
  static const String search = '/products/search';
  static const String categories = '/products/categories';
  static const String productById = '/products/'; // Append {id}

  // Headers
  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String accept = 'Accept';
  static const String userAgent = 'User-Agent';

  // Values
  static const String applicationJson = 'application/json';
  static const String bearerPrefix = 'Bearer ';

  // Query parameters
  static const String limitParam = 'limit';
  static const String skipParam = 'skip';
  static const String queryParam = 'q';
  static const String sortParam = 'sortBy';
  static const String orderParam = 'order';

  // Sort options
  static const String sortByTitle = 'title';
  static const String sortByPrice = 'price';
  static const String sortByRating = 'rating';
  static const String sortByDate = 'createdAt';

  // Order options
  static const String orderAsc = 'asc';
  static const String orderDesc = 'desc';
}
