import 'package:dio/dio.dart';

import '../config/http_config.dart';
import '../exception/api_exception.dart';

/// 重试拦截器 - 移除单例模式
class RetryInterceptor extends Interceptor {
  final RetryConfig? _config;
  final Dio? _dio;

  RetryInterceptor(this._config, [this._dio]);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldRetry(err) || err is ApiException) {
      handler.next(err);
      return;
    }

    final retryCount = err.requestOptions.extra['retry_count'] as int? ?? 0;
    final maxRetries = _config?.maxRetries ?? 3;

    if (retryCount >= maxRetries) {
      handler.next(err);
      return;
    }

    // 计算延迟时间
    final delay = _calculateDelay(retryCount);
    await Future.delayed(delay);

    // 更新重试次数
    err.requestOptions.extra['retry_count'] = retryCount + 1;

    try {
      // 使用传入的Dio实例重新发起请求，保留配置和拦截器链
      final response = await (_dio ?? Dio()).fetch(err.requestOptions);
      handler.resolve(response);
    } catch (e) {
      if (e is DioException) {
        handler.next(e);
      } else {
        handler.next(err);
      }
    }
  }

  /// 判断是否应该重试
  bool _shouldRetry(DioException error) {
    // 取消的请求不重试
    if (error.type == DioExceptionType.cancel) {
      return false;
    }

    // 检查状态码是否可重试
    final response = error.response;
    if (response != null) {
      final statusCode = response.statusCode;
      final retryableStatusCodes =
          _config?.retryableStatusCodes ?? [408, 429, 500, 502, 503, 504];
      return retryableStatusCodes.contains(statusCode);
    }

    // 网络错误和超时错误可以重试
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError;
  }

  /// 计算延迟时间（指数退避）
  Duration _calculateDelay(int retryCount) {
    final initialDelay = _config?.initialDelay ?? const Duration(seconds: 1);
    final backoffMultiplier = _config?.backoffMultiplier ?? 2.0;
    final maxDelay = _config?.maxDelay ?? const Duration(seconds: 30);

    final delayMs =
        (initialDelay.inMilliseconds * (backoffMultiplier * retryCount))
            .round();
    final delay = Duration(milliseconds: delayMs);

    return delay > maxDelay ? maxDelay : delay;
  }
}
