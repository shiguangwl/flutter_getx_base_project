import 'package:dio/dio.dart';
import 'package:liushui_app/network/custom_error_handler.dart';
import 'package:retrofit/http.dart';

import '../common/network/config/http_config.dart';
import '../common/network/http_service.dart';
import '../config/env/env.dart';
import 'models/auth_models.dart';
import 'models/base/result.dart';
import 'models/user_models.dart';
import 'parse_error_logger.dart';
import 'standard_token_provider.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  static RestClient? _client;
  static HttpService? _httpService;

  static RestClient getInstance() {
    if (_client == null) {
      _httpService = HttpService(
        HttpConfigBuilder()
            .baseUrl(Env.apiUrl)
            .tokenProvider(StandardTokenProvider())
            .errorHandler(CustomErrorHandler())
            .logConfig(LogConfig(
              enabled: Env.isDebug,
              logLevel: LogLevel.info,
              logRequestHeaders: false,
              logRequestBody: true,
              logResponseHeaders: false,
              logResponseBody: true,
            ))
            .addHeader("clientId", Env.clientId)
            .addHeader("platform", "APP")
            .addHeader("tenantId", Env.tenantId)
            .build(),
      );

      _client = RestClient(_httpService!.dio);
    }
    return _client!;
  }

  static HttpService getHttpService() {
    getInstance();
    return _httpService!;
  }

  // ==================== 用户认证相关 ====================

  /// 用户登录
  @POST("/app/auth/login")
  Future<Result<AppLoginVo>> login(
    @Body() AppLoginBo loginBo,
  );

  /// 退出登录
  @POST("/app/auth/logout")
  Future<Result<void>> logout();

  // ==================== 用户相关接口 ====================

  /// 获取登录用户信息
  @GET("/app/user/currentUserInfo")
  Future<Result<MbUserVo>> getCurrentUserInfo();
}
