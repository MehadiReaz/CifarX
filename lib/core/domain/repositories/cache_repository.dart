import 'package:cifarx/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class CacheRepository {
  Future<Either<Failure, void>> cacheData<T>(String key, T data);
  Future<Either<Failure, T?>> getCachedData<T>(String key);
  Future<Either<Failure, void>> clearCache(String key);
  Future<Either<Failure, void>> clearAllCache();
  Future<Either<Failure, bool>> hasData(String key);
}
