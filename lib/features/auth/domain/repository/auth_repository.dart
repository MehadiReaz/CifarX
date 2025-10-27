import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../params/login_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams params);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity?>> checkAuthStatus();
  Future<Either<Failure, UserEntity>> refreshToken(String refreshToken);
}
