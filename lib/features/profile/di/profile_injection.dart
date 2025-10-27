import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../data/data_sources/remote/profile_api_service.dart';

@module
abstract class ProfileModule {
  @lazySingleton
  ProfileApiService profileApiService(Dio dio) => ProfileApiService(dio);
}
