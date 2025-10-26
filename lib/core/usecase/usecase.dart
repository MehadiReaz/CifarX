import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';

/// Generic UseCase base class with functional error handling
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({Params? params});
}
