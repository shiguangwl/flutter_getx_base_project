import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/http_config.dart';
import '../exception/api_exception.dart';

/// Token 拦截器 - 移除单例模式
class TokenInterceptor extends Interceptor {
  final TokenProvider? _tokenProvider;
  final Dio? _dio;

  TokenInterceptor(this._tokenProvider, [this._dio]);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_tokenProvider != null) {
      try {
        final token = await _tokenProvider.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } catch (e) {
        // Token 获取失败，继续请求但不添加 token
        if (kDebugMode) print('Token获取失败: $e');
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 处理 401 未授权错误
    if (_isTokenExpired(err)) {
      try {
        // 尝试刷新 token
        await _tokenProvider!.refreshToken();
        // 重新获取 token
        final newToken = await _tokenProvider.getToken();
        if (newToken == null || newToken.isEmpty) {
          _tokenProvider.onRefreshTokenFailed(err);
          handler.next(err);
          return;
        }
        // 更新请求头
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        // 使用传入的Dio实例重新发起请求，保留配置和拦截器链
        final response = await (_dio ?? Dio()).fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        if (kDebugMode) print('Token刷新失败: $e');
      }
    }

    handler.next(err);
  }

  bool _isTokenExpired(DioException err) {
    if (_tokenProvider == null) {
      return false;
    }
    if (err is ApiException) {
      return err.code == 401;
    }
    return err.response?.statusCode == 401;
  }
}
