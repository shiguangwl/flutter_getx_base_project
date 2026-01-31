import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'config/http_config.dart';
import 'exception/network_exception.dart';
import 'interceptor/api_error_interceptor.dart';
import 'interceptor/cache_interceptor.dart';
import 'interceptor/http_error_interceptor.dart';
import 'interceptor/log_interceptor.dart';
import 'interceptor/retry_interceptor.dart';
import 'interceptor/token_interceptor.dart';

/// 网络服务类
class HttpService {
  late final Dio _dio;
  final HttpConfig _config;

  Dio get dio => _dio;

  HttpService(this._config) {
    _initializeDio();
    _initializeInterceptors();
  }

  /// 初始化 Dio 实例
  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: _config.baseUrl,
      connectTimeout: Duration(
        milliseconds: _config.connectTimeout,
      ),
      receiveTimeout: Duration(
        milliseconds: _config.receiveTimeout,
      ),
      sendTimeout: Duration(
        milliseconds: _config.sendTimeout,
      ),
      headers: _config.defaultHeaders,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
  }

  /// 初始化拦截器实例
  void _initializeInterceptors() {
    _dio.interceptors.addAll([
      TokenInterceptor(_config.tokenProvider, _dio),
      CacheInterceptor(_config.cacheConfig),
      RetryInterceptor(_config.retryConfig, _dio),
      ApiErrorInterceptor(_config.apiErrorConfig),
      HttpErrorInterceptor(_config.errorHandler),
      if (kDebugMode) CustomLogInterceptor(_config.logConfig),
    ]);
  }

  /// GET 请求
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return _handleResponse<T>(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// POST 请求
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _handleResponse<T>(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT 请求
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _handleResponse<T>(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE 请求
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse<T>(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 文件上传
  Future<T> upload<T>(
    String path,
    FormData formData, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return _handleResponse<T>(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 文件下载
  Future<Response> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Options? options,
  }) async {
    try {
      return await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        options: options,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// 处理响应
  T _handleResponse<T>(Response<T> response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return response.data as T;
    } else {
      throw NetworkException(
        code: response.statusCode ?? -1,
        message: 'HTTP Error: ${response.statusCode}',
        exceptionType: NetworkExceptionType.httpError,
      );
    }
  }

  /// 处理错误
  NetworkException _handleError(dynamic error) {
    return error;
  }

  /// 更新配置
  void updateConfig(HttpConfig newConfig) {
    _dio.options.baseUrl = newConfig.baseUrl;
    _dio.options.connectTimeout =
        Duration(milliseconds: newConfig.connectTimeout);
    _dio.options.receiveTimeout =
        Duration(milliseconds: newConfig.receiveTimeout);
    _dio.options.sendTimeout = Duration(milliseconds: newConfig.sendTimeout);
    _dio.options.headers.addAll(newConfig.defaultHeaders);
  }

  /// 清理资源
  void dispose() {
    _dio.close();
  }
}
