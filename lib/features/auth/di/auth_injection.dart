import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../data/data_sources/remote/login_api_service.dart';

@module
abstract class AuthModule {
  @lazySingleton
  LoginApiService loginApiService(Dio dio) => LoginApiService(dio);
}
