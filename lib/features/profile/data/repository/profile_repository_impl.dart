import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/error_handler.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_sources/remote/profile_api_service.dart';
import '../models/profile_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService profileApiService;
  final Logger _logger = Logger();

  ProfileRepositoryImpl(this.profileApiService);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final httpResponse = await profileApiService.getProfile();

      _logger.d('Profile Response: ${httpResponse.data}');
      final requestUri = httpResponse.response.requestOptions.uri;
      _logger.d('API URL (profile): $requestUri');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final profileModel = ProfileModel.fromJson(httpResponse.data);
        return Right(profileModel);
      } else {
        return Left(
          ServerFailure(
            'HTTP Error: ${httpResponse.response.statusCode}',
            statusCode: httpResponse.response.statusCode,
          ),
        );
      }
    } catch (e) {
      _logger.e('Profile fetch error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    }
  }
}