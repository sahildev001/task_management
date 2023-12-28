import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import 'models/login_result.dart';
part "rest_api_client.g.dart";

@RestApi(baseUrl: 'http://192.168.1.36:3000')
abstract class RestApiClient {
  factory RestApiClient(Dio dio) = _RestApiClient;

  @POST('/users/signin')
  Future<LoginResult> login(@Body() Map<String, dynamic> request);

 @POST('/users/signup')
  Future<LoginResult> signUp(@Body() Map<String, dynamic> request);



}
