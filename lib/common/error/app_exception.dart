/// 应用异常基类
/// 所有业务异常都应继承此类
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  /// 获取用户友好的错误消息
  String get userMessage => message;

  /// 是否可重试
  bool get isRetryable => false;

  @override
  String toString() => '$runtimeType(code: $code, message: $message)';
}

/// 业务逻辑异常
class BusinessException extends AppException {
  const BusinessException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  bool get isRetryable => false;
}

/// 认证异常
class AuthException extends AppException {
  final AuthExceptionType type;

  const AuthException({
    required this.type,
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory AuthException.unauthorized([String? message]) => AuthException(
        type: AuthExceptionType.unauthorized,
        message: message ?? '请先登录',
        code: '401',
      );

  factory AuthException.forbidden([String? message]) => AuthException(
        type: AuthExceptionType.forbidden,
        message: message ?? '没有权限访问',
        code: '403',
      );

  factory AuthException.tokenExpired([String? message]) => AuthException(
        type: AuthExceptionType.tokenExpired,
        message: message ?? '登录已过期，请重新登录',
        code: 'TOKEN_EXPIRED',
      );

  factory AuthException.tokenRefreshFailed([String? message]) => AuthException(
        type: AuthExceptionType.tokenRefreshFailed,
        message: message ?? 'Token刷新失败',
        code: 'TOKEN_REFRESH_FAILED',
      );

  @override
  String get userMessage {
    switch (type) {
      case AuthExceptionType.unauthorized:
        return '请先登录';
      case AuthExceptionType.forbidden:
        return '没有权限访问';
      case AuthExceptionType.tokenExpired:
        return '登录已过期，请重新登录';
      case AuthExceptionType.tokenRefreshFailed:
        return '登录失效，请重新登录';
    }
  }
}

enum AuthExceptionType {
  unauthorized,
  forbidden,
  tokenExpired,
  tokenRefreshFailed,
}

/// 数据验证异常
class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;

  const ValidationException({
    required super.message,
    this.fieldErrors,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory ValidationException.field(String field, String error) =>
      ValidationException(
        message: error,
        fieldErrors: {
          field: [error]
        },
        code: 'VALIDATION_ERROR',
      );

  factory ValidationException.fields(Map<String, List<String>> errors) =>
      ValidationException(
        message: errors.values.expand((e) => e).join('; '),
        fieldErrors: errors,
        code: 'VALIDATION_ERROR',
      );

  @override
  String get userMessage => message;
}

/// 资源未找到异常
class NotFoundException extends AppException {
  final String? resourceType;
  final String? resourceId;

  const NotFoundException({
    required super.message,
    this.resourceType,
    this.resourceId,
    super.code = '404',
    super.originalError,
    super.stackTrace,
  });

  factory NotFoundException.resource(String type, [String? id]) =>
      NotFoundException(
        message: id != null ? '$type(id: $id)不存在' : '$type不存在',
        resourceType: type,
        resourceId: id,
      );

  @override
  String get userMessage => '请求的资源不存在';
}

/// 状态冲突异常
class ConflictException extends AppException {
  const ConflictException({
    required super.message,
    super.code = '409',
    super.originalError,
    super.stackTrace,
  });

  @override
  String get userMessage => '操作冲突，请刷新后重试';
}
