
/// API base URL and endpoints for DummyJSON Products API
class ApiConstants {
	static const String baseUrl = 'https://dummyjson.com';

	// Products endpoints
	static const String products = '/products';
	static const String productById = '/products/'; // Replace {id} with actual product ID
	static const String productsSearch = '/products/search';

	// Query parameters
	static const String paramLimit = 'limit';
	static const String paramSkip = 'skip';
	static const String paramSelect = 'select';
	static const String paramSortBy = 'sortBy';
	static const String paramOrder = 'order';
	static const String paramQuery = 'q';
}
