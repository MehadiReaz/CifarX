import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repository/auth_repository.dart';

@injectable
class RefreshTokenUsecase {
  final AuthRepository repository;

  RefreshTokenUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call(String refreshToken) async {
    return await repository.refreshToken(refreshToken);
  }
}
