import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '/app/constants.dart';
import '/data/response/response.dart';

part 'api2.g.dart';

@RestApi(baseUrl: Constants.baseUrl2)
abstract class AppServiceClient2 {
  factory AppServiceClient2(Dio dio, {String baseUrl2}) = _AppServiceClient2;

  @POST("")
  Future<MessageResponse> sendMessage(
    @Field("text") String text,
    @Field("createdAt") String createdAt,
    @Field("id") String id,
  );

  @GET("")
  Future<Map<String, MessageResponse>> getMessages();
}
