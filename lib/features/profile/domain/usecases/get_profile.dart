import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/domain/usecases/base_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile.dart';
import '../repository/profile_repository.dart';

@lazySingleton
class GetProfileUsecase extends BaseUseCase<ProfileEntity, NoParams> {
  final ProfileRepository profileRepository;

  GetProfileUsecase(this.profileRepository);

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) {
    return profileRepository.getProfile();
  }
}