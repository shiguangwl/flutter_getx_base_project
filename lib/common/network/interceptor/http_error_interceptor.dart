import 'package:dio/dio.dart';
import '../../log/logger.dart';
import '../config/http_config.dart';
import '../exception/api_exception.dart';
import '../exception/network_exception.dart';

/// HTTP错误拦截器
class HttpErrorInterceptor extends Interceptor {
  final ErrorHandler? _errorHandler;

  HttpErrorInterceptor(this._errorHandler);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.e('HTTP错误拦截器', err);
    final exception =
        err is ApiException ? err : _convertToNetworkException(err);
    _errorHandler?.onError(exception);
    handler.next(exception);
  }

  /// 将 DioException 转换为 NetworkException
  NetworkException _convertToNetworkException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException.timeout(
          message: '连接超时',
          originalError: error,
          stackTrace: error.stackTrace,
        );
      case DioExceptionType.sendTimeout:
        return NetworkException.timeout(
          message: '发送超时',
          originalError: error,
          stackTrace: error.stackTrace,
        );
      case DioExceptionType.receiveTimeout:
        return NetworkException.timeout(
          message: '接收超时',
          originalError: error,
          stackTrace: error.stackTrace,
        );
      case DioExceptionType.badResponse:
        return NetworkException.httpError(
          code: error.response?.statusCode ?? -1,
          message: error.response?.statusMessage ?? '服务器错误',
          originalError: error,
          stackTrace: error.stackTrace,
        );
      case DioExceptionType.cancel:
        return NetworkException.cancel(
          message: '请求已取消',
          originalError: error,
          stackTrace: error.stackTrace,
        );
      case DioExceptionType.connectionError:
        return NetworkException.network(
          message: '网络连接错误',
          originalError: error,
          stackTrace: error.stackTrace,
        );
      default:
        return NetworkException.unknown(
          message: error.message ?? '未知错误',
          originalError: error,
          stackTrace: error.stackTrace,
        );
    }
  }
}
