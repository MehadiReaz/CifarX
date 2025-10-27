import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:cifarx/core/domain/usecases/base_usecase.dart';
import 'package:cifarx/core/error/failures.dart';
import '../entities/product.dart';
import '../params/product_search_params.dart';
import '../repository/product_repository.dart';

@lazySingleton
class SearchProductsUsecase
    extends BaseUseCase<ProductListEntity, ProductSearchParams> {
  final ProductRepository productRepository;

  SearchProductsUsecase(this.productRepository);

  @override
  Future<Either<Failure, ProductListEntity>> call(ProductSearchParams params) {
    return productRepository.searchProducts(
      params.query,
      limit: params.limit,
      skip: params.skip,
      sort: params.sort,
      order: params.order,
    );
  }
}
