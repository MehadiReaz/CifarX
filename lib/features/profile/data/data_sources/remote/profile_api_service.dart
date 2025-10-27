import 'package:cifarx/core/constants/api_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'profile_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio,
      {String? baseUrl, ParseErrorLogger? errorLogger}) = _ProfileApiService;

  @GET(ApiConstants.profile)
  Future<HttpResponse> getProfile();
}