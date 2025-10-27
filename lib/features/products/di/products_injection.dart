import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:cifarx/features/products/data/data_sources/remote/product_api_service.dart';

@module
abstract class ProductsModule {
  @lazySingleton
  ProductApiService productApiService(Dio dio) => ProductApiService(dio);
}
