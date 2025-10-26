import 'package:cifarx/core/error/failures.dart';
import 'package:cifarx/core/usecase/usecase.dart';
import 'package:cifarx/features/products/domain/entity/product_entity.dart';
import 'package:cifarx/features/products/domain/repository/product_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Parameters for pagination
class PaginationParams {
  final int limit;
  final int skip;

  const PaginationParams({required this.limit, required this.skip});
}

/// Use case: Get paginated products
class GetPaginatedProductsUseCase
    extends UseCase<List<ProductEntity>, PaginationParams> {
  final ProductRepository repository;

  GetPaginatedProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call({PaginationParams? params}) async {
    if (params == null) {
      return Left(InvalidParamsFailure('Pagination parameters missing'));
    }

    return await repository.getProducts(
      limit: params.limit,
      skip: params.skip,
    );
  }
}
