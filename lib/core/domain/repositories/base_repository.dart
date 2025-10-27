import 'package:cifarx/core/error/failures.dart';

abstract class BaseRepository {
  Future<T> handleError<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } catch (e) {
      throw _mapExceptionToFailure(e);
    }
  }

  Failure _mapExceptionToFailure(dynamic exception) {
    if (exception is Failure) {
      return exception;
    }
    return UnknownFailure(exception.toString());
  }
}
