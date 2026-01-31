import 'package:dio/dio.dart';

/// API异常
class ApiException extends DioException {
  final int code;
  final dynamic cause;
  final String? _message;

  ApiException({
    required this.code,
    RequestOptions? requestOptions,
    super.message,
    this.cause,
    super.response,
    super.type,
    super.error,
    super.stackTrace,
  })  : _message = message,
        super(
          requestOptions: requestOptions ?? RequestOptions(path: ''),
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
      message: message ?? _message,
      cause: cause,
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      type: type ?? this.type,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  // Removed _init() which attempted to mutate (potentially final) fields of DioException
}
