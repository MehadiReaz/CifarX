import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cifarx/core/domain/usecases/base_usecase.dart';
import 'package:cifarx/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

class ConnectivityUseCase extends BaseUseCase<bool, NoParams> {
  final Connectivity _connectivity;

  ConnectivityUseCase(this._connectivity);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      final result = await _connectivity.checkConnectivity();
      return Right(result != ConnectivityResult.none);
    } catch (e) {
      return Left(NetworkFailure('Failed to check connectivity'));
    }
  }
}
