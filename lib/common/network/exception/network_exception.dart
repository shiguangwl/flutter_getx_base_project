import 'package:dio/dio.dart';

/// 网络异常类型
enum NetworkExceptionType {
  /// 网络连接错误
  network,

  /// 超时错误
  timeout,

  /// HTTP 错误
  httpError,

  /// 请求取消
  cancel,

  /// 解析错误
  parse,

  /// 未知错误
  unknown,
}

/// 网络异常类
class NetworkException extends DioException {
  final int code;
  final NetworkExceptionType exceptionType;
  final dynamic originalError;
  final String? _message;

  NetworkException({
    required this.code,
    required this.exceptionType,
    super.message,
    this.originalError,
    RequestOptions? requestOptions,
    super.response,
    DioExceptionType? type,
    Object? error,
    super.stackTrace,
  })  : _message = message,
        super(
          requestOptions: requestOptions ?? RequestOptions(path: ''),
          type: type ?? _mapToNetworkExceptionType(exceptionType),
          error: error ?? originalError,
        );

  /// 将NetworkExceptionType映射到DioExceptionType
  static DioExceptionType _mapToNetworkExceptionType(
      NetworkExceptionType type) {
    switch (type) {
      case NetworkExceptionType.network:
        return DioExceptionType.connectionError;
      case NetworkExceptionType.timeout:
        return DioExceptionType.connectionTimeout;
      case NetworkExceptionType.httpError:
        return DioExceptionType.badResponse;
      case NetworkExceptionType.cancel:
        return DioExceptionType.cancel;
      case NetworkExceptionType.parse:
        return DioExceptionType.unknown;
      case NetworkExceptionType.unknown:
        return DioExceptionType.unknown;
    }
  }

  @override
  String get message =>
      _message ?? originalError?.toString() ?? super.message ?? '';

  /// 创建网络连接异常
  factory NetworkException.network({
    String message = '网络连接失败',
    dynamic originalError,
    StackTrace? stackTrace,
    RequestOptions? requestOptions,
  }) {
    return NetworkException(
      code: -1001,
      message: message,
      exceptionType: NetworkExceptionType.network,
      originalError: originalError,
      stackTrace: stackTrace,
      requestOptions: requestOptions,
    );
  }

  /// 创建超时异常
  factory NetworkException.timeout({
    String message = '请求超时',
    dynamic originalError,
    StackTrace? stackTrace,
    RequestOptions? requestOptions,
  }) {
    return NetworkException(
      code: -1002,
      message: message,
      exceptionType: NetworkExceptionType.timeout,
      originalError: originalError,
      stackTrace: stackTrace,
      requestOptions: requestOptions,
    );
  }

  /// 创建HTTP错误异常
  factory NetworkException.httpError({
    required int code,
    String? message,
    dynamic originalError,
    StackTrace? stackTrace,
    RequestOptions? requestOptions,
    Response? response,
  }) {
    return NetworkException(
      code: code,
      message: message ?? 'HTTP错误: $code',
      exceptionType: NetworkExceptionType.httpError,
      originalError: originalError,
      stackTrace: stackTrace,
      requestOptions: requestOptions,
      response: response,
    );
  }

  /// 创建取消异常
  factory NetworkException.cancel({
    String message = '请求已取消',
    dynamic originalError,
    StackTrace? stackTrace,
    RequestOptions? requestOptions,
  }) {
    return NetworkException(
      code: -1003,
      message: message,
      exceptionType: NetworkExceptionType.cancel,
      originalError: originalError,
      stackTrace: stackTrace,
      requestOptions: requestOptions,
    );
  }

  /// 创建解析异常
  factory NetworkException.parse({
    String message = '数据解析失败',
    dynamic originalError,
    StackTrace? stackTrace,
    RequestOptions? requestOptions,
  }) {
    return NetworkException(
      code: -1004,
      message: message,
      exceptionType: NetworkExceptionType.parse,
      originalError: originalError,
      stackTrace: stackTrace,
      requestOptions: requestOptions,
    );
  }

  /// 创建未知异常
  factory NetworkException.unknown({
    String message = '未知错误',
    dynamic originalError,
    StackTrace? stackTrace,
    RequestOptions? requestOptions,
  }) {
    return NetworkException(
      code: -1000,
      message: message,
      exceptionType: NetworkExceptionType.unknown,
      originalError: originalError,
      stackTrace: stackTrace,
      requestOptions: requestOptions,
    );
  }

  /// 是否为网络错误
  bool get isNetworkError => exceptionType == NetworkExceptionType.network;

  /// 是否为超时错误
  bool get isTimeoutError => exceptionType == NetworkExceptionType.timeout;

  /// 是否为HTTP错误
  bool get isHttpError => exceptionType == NetworkExceptionType.httpError;

  /// 是否为取消错误
  bool get isCancelError => exceptionType == NetworkExceptionType.cancel;

  /// 是否为解析错误
  bool get isParseError => exceptionType == NetworkExceptionType.parse;

  /// 是否为未知错误
  bool get isUnknownError => exceptionType == NetworkExceptionType.unknown;

  /// 是否为客户端错误 (4xx)
  bool get isClientError => isHttpError && code >= 400 && code < 500;

  /// 是否为服务器错误 (5xx)
  bool get isServerError => isHttpError && code >= 500 && code < 600;

  /// 获取用户友好的错误消息
  String get userFriendlyMessage {
    switch (exceptionType) {
      case NetworkExceptionType.network:
        return '网络连接失败，请检查网络设置';
      case NetworkExceptionType.timeout:
        return '请求超时，请稍后重试';
      case NetworkExceptionType.httpError:
        if (isClientError) {
          switch (code) {
            case 400:
              return '请求参数错误';
            case 401:
              return '身份验证失败，请重新登录';
            case 403:
              return '没有访问权限';
            case 404:
              return '请求的资源不存在';
            case 429:
              return '请求过于频繁，请稍后重试';
            default:
              return '客户端错误: $code';
          }
        } else if (isServerError) {
          switch (code) {
            case 500:
              return '服务器内部错误';
            case 502:
              return '网关错误';
            case 503:
              return '服务暂时不可用';
            case 504:
              return '网关超时';
            default:
              return '服务器错误: $code';
          }
        }
        return message;
      case NetworkExceptionType.cancel:
        return '请求已取消';
      case NetworkExceptionType.parse:
        return '数据格式错误';
      case NetworkExceptionType.unknown:
        return '未知错误，请稍后重试';
    }
  }

  /// 复制异常对象
  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return NetworkException(
      code: code,
      exceptionType: exceptionType,
      message: message ?? _message,
      originalError: originalError,
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      type: type ?? this.type,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  String toString() {
    var str =
        'NetworkException(code: $code, message: $message, type: $exceptionType)';
    if (originalError is Error) {
      str += '\n${(originalError as Error).stackTrace}';
    }
    return str;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NetworkException &&
        other.code == code &&
        other.message == message &&
        other.exceptionType == exceptionType;
  }

  @override
  int get hashCode {
    return code.hashCode ^ message.hashCode ^ exceptionType.hashCode;
  }
}
