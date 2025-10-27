import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/domain/usecases/base_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../params/login_params.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class LoginUserUsecase extends BaseUseCase<UserEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUserUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return authRepository.login(params);
  }
}
