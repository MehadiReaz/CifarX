import 'package:cifarx/features/products/data/services/product_api_service.dart';

import '../models/product_list_model.dart';
import '../models/product_model.dart';
import '../../../../core/network/api_client.dart';

abstract class ProductRemoteDataSource {
  Future<ProductListModel> getPaginatedProducts(int page, int limit);
  Future<ProductModel> getProductDetails(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ProductApiService apiService;

  ProductRemoteDataSourceImpl()
      : apiService = ProductApiService(ApiClient.createDio());

  @override
  Future<ProductListModel> getPaginatedProducts(int page, int limit) {
    return apiService.getProducts(page, limit);
  }

  @override
  Future<ProductModel> getProductDetails(String id) {
    return apiService.getProductDetails(id);
  }
}
