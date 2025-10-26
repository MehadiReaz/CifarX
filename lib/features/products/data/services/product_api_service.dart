import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/product_list_model.dart';
import '../models/product_model.dart';

part 'product_api_service.g.dart';

@RestApi()
abstract class ProductApiService {
  factory ProductApiService(Dio dio, {String baseUrl}) = _ProductApiService;

  @GET(ApiConstants.products)
  Future<ProductListModel> getProducts(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @GET(ApiConstants.productById)
  Future<ProductModel> getProductDetails(@Path('id') String id);

  @GET(ApiConstants.productsSearch)
  Future<ProductListModel> searchProducts(
    @Query('query') String query,
    @Query('page') int page,
    @Query('limit') int limit,
  );
}
