import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:cifarx/core/domain/usecases/base_usecase.dart';
import 'package:cifarx/core/error/failures.dart';
import '../entities/product.dart';
import '../params/product_id_params.dart';
import '../repository/product_repository.dart';

@lazySingleton
class GetProductByIdUsecase
    extends BaseUseCase<ProductEntity, ProductIdParams> {
  final ProductRepository productRepository;

  GetProductByIdUsecase(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> call(ProductIdParams params) {
    return productRepository.getProductById(params.id);
  }
}
