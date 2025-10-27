import 'package:cifarx/core/constants/api_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'product_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProductApiService {
  factory ProductApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ProductApiService;

  @GET(ApiConstants.products)
  Future<HttpResponse> getProducts({
    @Query('limit') int? limit,
    @Query('skip') int? skip,
    @Query('select') String? select,
    @Query('sortBy') String? sort,
    @Query('order') String? order,
  });

  @GET(ApiConstants.search)
  Future<HttpResponse> searchProducts({
    @Query('q') required String query,
    @Query('limit') int? limit,
    @Query('skip') int? skip,
    @Query('sortBy') String? sort,
    @Query('order') String? order,
  });

  @GET('${ApiConstants.productById}{id}')
  Future<HttpResponse> getProductById({@Path('id') required int id});
}
