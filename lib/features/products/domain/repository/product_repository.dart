import 'package:cifarx/core/error/failures.dart';
import 'package:cifarx/features/products/domain/entity/product_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required int limit,
    required int skip,
  });

  Future<Either<Failure, List<ProductEntity>>> searchProducts({
    required String query,
    required int limit,
    required int skip,
  });

  Future<Either<Failure, ProductEntity>> getProductDetails(String productId);
}
