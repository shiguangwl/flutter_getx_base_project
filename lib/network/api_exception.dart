import 'package:dio/dio.dart';

/// 自定义API异常
class ApiException extends DioException {
  static const CODE_SUCCESS = 0;
  static const CODE_UNKNOWN = 1000;

  final int code;
  final dynamic cause;
  final String? _message;

  ApiException({
    required this.code,
    String? message,
    this.cause,
    RequestOptions? requestOptions,
  })  : _message = message,
        super(
          requestOptions: requestOptions ?? RequestOptions(path: ''),
          type: DioExceptionType.unknown,
        );

  @override
  String get message => _message ?? cause?.toString() ?? '';

  @override
  String toString() {
    var str = 'ApiException{code: $code, message: $message, cause: $cause}';
    if (cause is Error) {
      str += '\n${(cause as Error).stackTrace}';
    }
    return str;
  }

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return ApiException(
      code: code,
      message: message ?? this.message,
      cause: cause,
      requestOptions: requestOptions ?? this.requestOptions,
    ).._init(
        response: response ?? this.response,
        type: type ?? this.type,
        error: error ?? this.error,
        stackTrace: stackTrace ?? this.stackTrace,
      );
  }

  DioException _init({
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final instance = this as dynamic;
    instance.response = response;
    instance.type = type;
    instance.error = error;
    instance.stackTrace = stackTrace;
    return this;
  }
}