import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../log/logger.dart';
import '../config/http_config.dart';

/// 自定义日志拦截器 - 移除单例模式
class CustomLogInterceptor extends Interceptor {
  final LogConfig? _config;

  CustomLogInterceptor(this._config);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_shouldLog(LogLevel.info)) {
      _logRequest(options);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_shouldLog(LogLevel.info)) {
      _logResponse(response);
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_shouldLog(LogLevel.error)) {
      _logError(err);
    }
    handler.next(err);
  }

  /// 判断是否应该记录日志
  bool _shouldLog(LogLevel level) {
    if (_config?.enabled != true) return false;

    final configLevel = _config?.logLevel ?? LogLevel.info;
    return level.index >= configLevel.index;
  }

  /// 记录请求日志
  void _logRequest(RequestOptions options) {
    final buffer = StringBuffer();
    buffer.writeln(
        '┌─────────────────────────────────────────────────────────────');
    buffer.writeln('│ REQUEST: ${options.method.toUpperCase()} ${options.uri}');
    buffer.writeln(
        '├─────────────────────────────────────────────────────────────');

    final headers = options.headers;
    if (_config?.logRequestHeaders == true) {
      if (headers.isNotEmpty) {
        buffer.writeln('│ Headers:');
        headers.forEach((key, value) {
          buffer.writeln('│   $key: $value');
        });
      } else {
        buffer.writeln('│   No headers');
      }
      ;
    }

    if (_config?.logRequestBody == true) {
      buffer.writeln('│ Body:');
      if (options.data != null) {
        buffer.writeln('│   ${_formatData(options.data)}');
      } else {
        buffer.writeln('│    No body');
      }
    }

    buffer.writeln(
        '└─────────────────────────────────────────────────────────────');

    if (kDebugMode) {
      Log.i(buffer.toString());
    }
  }

  /// 记录响应日志
  void _logResponse(Response response) {
    final buffer = StringBuffer();
    buffer.writeln(
        '┌─────────────────────────────────────────────────────────────');
    buffer.writeln(
        '│ RESPONSE: ${response.requestOptions.method.toUpperCase()} ${response.requestOptions.uri}');
    buffer.writeln(
        '├─────────────────────────────────────────────────────────────');
    buffer.writeln(
        '│ Status Code: ${response.statusCode} ${response.statusMessage}');

    final responseHeaders = response.headers.map;
    if (_config?.logResponseHeaders == true && responseHeaders.isNotEmpty) {
      buffer.writeln(
          '├─────────────────────────────────────────────────────────────');
      buffer.writeln('│ Headers:');
      responseHeaders.forEach((key, value) {
        buffer.writeln('│   $key: ${value.join(', ')}');
      });
    }

    if (_config?.logResponseBody == true) {
      if (response.data != null) {
        buffer.writeln(
            '├─────────────────────────────────────────────────────────────');
        buffer.writeln('│ Body:');
        buffer.writeln('│   ${_formatData(response.data)}');
      } else {
        buffer.writeln('│   No body');
      }
    }

    buffer.writeln(
        '└─────────────────────────────────────────────────────────────');

    if (kDebugMode) {
      Log.i(buffer.toString());
    }
  }

  /// 记录错误日志
  void _logError(DioException error) {
    final buffer = StringBuffer();
    buffer.writeln(
        '┌─────────────────────────────────────────────────────────────');
    buffer.writeln(
        '│ REQUEST ERROR: ${error.requestOptions.method.toUpperCase()} ${error.requestOptions.uri}');
    buffer.writeln(
        '├─────────────────────────────────────────────────────────────');
    buffer.writeln('│ Error Type: ${error.type}');

    final errorResponse = error.response;
    if (errorResponse != null) {
      buffer.writeln(
          '│ Status Code: ${errorResponse.statusCode} ${errorResponse.statusMessage}');
    }

    if (error.message != null) {
      buffer.writeln(
          '├─────────────────────────────────────────────────────────────');
      buffer.writeln('│ Message:');
      buffer.writeln('│   ${error.message}');
    }

    final errorResponseData = error.response?.data;
    if (errorResponseData != null) {
      buffer.writeln(
          '├─────────────────────────────────────────────────────────────');
      buffer.writeln('│ Response Data:');
      buffer.writeln('│   ${_formatData(errorResponseData)}');
    }

    buffer.writeln(
        '└─────────────────────────────────────────────────────────────');

    if (kDebugMode) {
      Log.i(buffer.toString());
    }
  }

  /// 格式化数据
  String _formatData(dynamic data) {
    if (data == null) return 'null';

    try {
      if (data is String) {
        return data.length > 1000 ? '${data.substring(0, 1000)}...' : data;
      } else if (data is Map || data is List) {
        final jsonString = data.toString();
        return jsonString.length > 1000
            ? '${jsonString.substring(0, 1000)}...'
            : jsonString;
      } else {
        return data.toString();
      }
    } catch (e) {
      return 'Failed to format data: $e';
    }
  }
}
