import 'app_exception.dart';

/// 存储相关异常
class StorageException extends AppException {
  final StorageExceptionType type;

  const StorageException({
    required this.type,
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory StorageException.readFailed([String? message]) => StorageException(
        type: StorageExceptionType.readFailed,
        message: message ?? '读取数据失败',
        code: 'STORAGE_READ_FAILED',
      );

  factory StorageException.writeFailed([String? message]) => StorageException(
        type: StorageExceptionType.writeFailed,
        message: message ?? '写入数据失败',
        code: 'STORAGE_WRITE_FAILED',
      );

  factory StorageException.deleteFailed([String? message]) => StorageException(
        type: StorageExceptionType.deleteFailed,
        message: message ?? '删除数据失败',
        code: 'STORAGE_DELETE_FAILED',
      );

  factory StorageException.notFound([String? message]) => StorageException(
        type: StorageExceptionType.notFound,
        message: message ?? '数据不存在',
        code: 'STORAGE_NOT_FOUND',
      );

  factory StorageException.encryptionFailed([String? message]) =>
      StorageException(
        type: StorageExceptionType.encryptionFailed,
        message: message ?? '数据加密失败',
        code: 'STORAGE_ENCRYPTION_FAILED',
      );

  @override
  bool get isRetryable =>
      type == StorageExceptionType.readFailed ||
      type == StorageExceptionType.writeFailed;

  @override
  String get userMessage {
    switch (type) {
      case StorageExceptionType.readFailed:
        return '读取数据失败，请重试';
      case StorageExceptionType.writeFailed:
        return '保存数据失败，请重试';
      case StorageExceptionType.deleteFailed:
        return '删除数据失败';
      case StorageExceptionType.notFound:
        return '数据不存在';
      case StorageExceptionType.encryptionFailed:
        return '数据处理失败';
    }
  }
}

enum StorageExceptionType {
  readFailed,
  writeFailed,
  deleteFailed,
  notFound,
  encryptionFailed,
}

/// 服务相关异常
class ServiceException extends AppException {
  final ServiceExceptionType type;

  const ServiceException({
    required this.type,
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  factory ServiceException.unavailable([String? message]) => ServiceException(
        type: ServiceExceptionType.unavailable,
        message: message ?? '服务暂时不可用',
        code: 'SERVICE_UNAVAILABLE',
      );

  factory ServiceException.timeout([String? message]) => ServiceException(
        type: ServiceExceptionType.timeout,
        message: message ?? '服务响应超时',
        code: 'SERVICE_TIMEOUT',
      );

  factory ServiceException.maintenance([String? message]) => ServiceException(
        type: ServiceExceptionType.maintenance,
        message: message ?? '服务正在维护中',
        code: 'SERVICE_MAINTENANCE',
      );

  @override
  bool get isRetryable =>
      type == ServiceExceptionType.unavailable ||
      type == ServiceExceptionType.timeout;

  @override
  String get userMessage {
    switch (type) {
      case ServiceExceptionType.unavailable:
        return '服务暂时不可用，请稍后重试';
      case ServiceExceptionType.timeout:
        return '请求超时，请检查网络后重试';
      case ServiceExceptionType.maintenance:
        return '服务正在维护中，请稍后再试';
    }
  }
}

enum ServiceExceptionType {
  unavailable,
  timeout,
  maintenance,
}

/// 解析相关异常
class ParseException extends AppException {
  const ParseException({
    required super.message,
    super.code = 'PARSE_ERROR',
    super.originalError,
    super.stackTrace,
  });

  factory ParseException.json([String? message]) => ParseException(
        message: message ?? 'JSON解析失败',
      );

  factory ParseException.date([String? message]) => ParseException(
        message: message ?? '日期格式解析失败',
      );

  @override
  String get userMessage => '数据格式错误';
}
