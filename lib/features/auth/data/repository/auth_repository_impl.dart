import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/storage/token_storage_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/params/login_params.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/remote/login_api_service.dart';
import '../models/login_request.dart';
import '../models/refresh_token_request.dart';
import '../models/user_model.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final LoginApiService loginApiService;
  final TokenStorageService tokenStorageService;
  final Logger _logger = Logger();

  AuthRepositoryImpl(this.loginApiService, this.tokenStorageService);

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    try {
      final loginRequest = LoginRequest(
        username: params.username,
        password: params.password,
        expiresInMins: params.expiresInMins,
      );

      final httpResponse = await loginApiService.login(loginRequest);

      _logger.d('Login Response: ${httpResponse.data}');
      final requestUri = httpResponse.response.requestOptions.uri;
      _logger.d('API URL (login): $requestUri');
      _logger.d('Login Request: ${loginRequest.toJson()}');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final userModel = UserModel.fromJson(httpResponse.data);
        return Right(userModel);
      } else {
        return Left(
          ServerFailure(
            'HTTP Error: ${httpResponse.response.statusCode}',
            statusCode: httpResponse.response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('Login Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    } catch (e) {
      _logger.e('Login Unexpected Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // TODO: Implement logout logic (clear tokens, etc.)
      return const Right(null);
    } catch (e) {
      _logger.e('Logout Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> checkAuthStatus() async {
    try {
      // TODO: Implement check auth status logic
      return const Right(null);
    } catch (e) {
      _logger.e('Check Auth Status Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> refreshToken(String refreshToken) async {
    try {
      final refreshRequest = RefreshTokenRequest(refreshToken: refreshToken);

      final httpResponse = await loginApiService.refreshToken(refreshRequest);

      _logger.d('Refresh Token Response: ${httpResponse.data.refreshToken}');
      final requestUri = httpResponse.response.requestOptions.uri;
      _logger.d('API URL (refresh): $requestUri');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Get the current user data from storage
        final storedUserData = await tokenStorageService.getUserData();
        if (storedUserData == null) {
          return Left(ServerFailure('No stored user data found'));
        }

        // Get the refresh token response data
        final refreshResponse = httpResponse.data;

        // Create a map from stored user data and update tokens
        final userMap = Map<String, dynamic>.from(storedUserData);
        userMap['accessToken'] = refreshResponse.accessToken;
        userMap['refreshToken'] = refreshResponse.refreshToken;

        // Create updated user model
        final userModel = UserModel.fromJson(userMap);
        return Right(userModel);
      } else {
        return Left(
          ServerFailure(
            'HTTP Error: ${httpResponse.response.statusCode}',
            statusCode: httpResponse.response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('Refresh Token Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    } catch (e) {
      _logger.e('Refresh Token Unexpected Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    }
  }
}
