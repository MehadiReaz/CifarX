import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:cifarx/core/domain/usecases/base_usecase.dart';
import 'package:cifarx/core/error/failures.dart';
import '../entities/product.dart';
import '../params/products_params.dart';
import '../repository/product_repository.dart';

@lazySingleton
class GetProductsUsecase
    extends BaseUseCase<ProductListEntity, ProductsParams> {
  final ProductRepository productRepository;

  GetProductsUsecase(this.productRepository);

  @override
  Future<Either<Failure, ProductListEntity>> call(ProductsParams params) {
    return productRepository.getProducts(
      limit: params.limit,
      skip: params.skip,
      sort: params.sort,
      order: params.order,
    );
  }
}
