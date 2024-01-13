import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '/app/constants.dart';
import '/data/response/response.dart';

part 'api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('signInWithPassword?key=AIzaSyCUk3auUMYCKe6-2IbucdY3HWz8UdzMFVk')
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      @Field("returnSecureToken") bool returnSecureToken);

  @POST('signUp?key=AIzaSyCUk3auUMYCKe6-2IbucdY3HWz8UdzMFVk')
  Future<AuthenticationResponse> register(
      @Field("email") String email,
      @Field("password") String password,
      @Field("returnSecureToken") bool returnSecureToken);
}
