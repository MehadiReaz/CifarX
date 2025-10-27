import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../models/login_request.dart';
import '../../models/refresh_token_request.dart';
import '../../models/refresh_token_response.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio,
      {String? baseUrl, ParseErrorLogger? errorLogger}) = _LoginApiService;

  @POST(ApiConstants.login)
  Future<HttpResponse> login(@Body() LoginRequest request);

  @POST(ApiConstants.refreshToken)
  Future<HttpResponse<RefreshTokenResponse>> refreshToken(
      @Body() RefreshTokenRequest request);
}
