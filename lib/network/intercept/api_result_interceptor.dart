import 'dart:convert';
import 'package:dio/dio.dart';
import '../../network/result.dart';
import '../../utils/log_util.dart';
import '../api_exception.dart';

class ApiResultInterceptor extends Interceptor {
  @override
  Future<void> onResponse(
      Response resp, ResponseInterceptorHandler handler) async {
    var decode = utf8.decode(resp.data);
    resp.data = json.decode(decode);
    String urlPath = resp.requestOptions.path;
    logD('response-urlPath--->:$urlPath');
    logD('response--->:${json.encode(resp.data ?? {})}');

    /// http error错误处理
    if (resp.statusCode != 200) {
      handler.reject(
          DioException(requestOptions: resp.requestOptions, response: resp),
          true);
      return;
    }
    // 业务错误处理
    var data = resp.data as Map<String, dynamic>;
    final result = Result<dynamic>.fromMapJson(data);

    // 根据状态码处理不同情况
    switch (data['code']) {
      case 401:
        // 登录状态已过期
        handler.reject(ApiException(code: 401, message: "401没有权限"), true);
        return;
      case 200:
        handler.next(resp);
        return;
      default:
        handler.reject(
            ApiException(
              code: result.code,
              message: result.msg,
              requestOptions: resp.requestOptions,
            ),
            true);
        return;
    }
  }
}
