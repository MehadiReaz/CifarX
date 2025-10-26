import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_sources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final model = await remoteDataSource.getPaginatedProducts(skip, limit);
      final entities = model.products.map((p) => p.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch products: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts({
    required String query,
    required int limit,
    required int skip,
  }) async {
    try {
      // final model = await remoteDataSource.searchProducts(query, limit, skip);
      // final entities = model.products.map((p) => p.toEntity()).toList();
      // return Right(entities);
      return Right([]);
    } catch (e) {
      return Left(ServerFailure('Failed to search products: $e'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(String productId) async {
    try {
      final model = await remoteDataSource.getProductDetails(productId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure('Failed to fetch product details: $e'));
    }
  }
}
