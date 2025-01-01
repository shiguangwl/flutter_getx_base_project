import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../result.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // APP基本配置接口
  @GET("/app/public/sysConfig")
  Future<Result<String>> sysConfig();

  // 用户登录
  @POST("/app/auth/login")
  Future<Result<String>> login(@Body() Map<String,String> loginModel);


}
