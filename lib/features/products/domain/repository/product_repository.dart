import 'package:cifarx/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductListEntity>> getProducts({
    required int limit,
    required int skip,
    String? sort,
    String? order,
  });

  Future<Either<Failure, ProductListEntity>> searchProducts(
    String query, {
    int? limit,
    int? skip,
    String? sort,
    String? order,
  });

  Future<Either<Failure, ProductEntity>> getProductById(int id);
}
