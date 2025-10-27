import 'package:cifarx/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
