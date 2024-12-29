import 'package:dio/dio.dart';

import '../config/env.dart';
import 'client/rest_client.dart';
import 'intercept/api_result_interceptor.dart';
import 'intercept/error_interceptor.dart';
import 'intercept/middle_interceptor.dart';
import 'intercept/rest_api_Interceptor.dart';

class Http {
  final String baseUrl = Env.getEnvConfig(env: Env.currEnv).baseUrl;

  ///超时时间
  static const Duration connectTimeout = Duration(milliseconds: 20 * 1000);

  static const Duration receiveTimeout = Duration(milliseconds: 20 * 1000);

  static final Http _instance = Http._internal();

  factory Http() => _instance;

  late Dio dio;
  late RestClient client;

  Http._internal() {
    BaseOptions options = BaseOptions(
      connectTimeout: connectTimeout,

      /// 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: receiveTimeout,
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.bytes,
      receiveDataWhenStatusError: false,
    );

    dio = Dio(options);
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback = (cert, host, port) {
    //     return true;
    //   };
    //   return null;
    // };

    // 添加error拦截器
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(MiddleInterceptor());
    dio.interceptors.add(ApiResultInterceptor());
    dio.interceptors.add(ErrorInterceptor());
    client = RestClient(dio, baseUrl: baseUrl);
  }
}
