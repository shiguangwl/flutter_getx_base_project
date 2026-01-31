import 'package:flutter_test/flutter_test.dart';
import 'package:liushui_app/common/error/app_exception.dart';
import 'package:liushui_app/common/error/app_exceptions.dart';

void main() {
  group('AppException Tests', () {
    test('BusinessException should have correct properties', () {
      const exception = BusinessException(
        message: 'Business error',
        code: 'BIZ_001',
      );

      expect(exception.message, 'Business error');
      expect(exception.code, 'BIZ_001');
      expect(exception.isRetryable, false);
      expect(exception.userMessage, 'Business error');
    });

    test('AuthException.unauthorized factory works correctly', () {
      final exception = AuthException.unauthorized();

      expect(exception.type, AuthExceptionType.unauthorized);
      expect(exception.code, '401');
      expect(exception.userMessage, '请先登录');
    });

    test('AuthException.tokenExpired factory works correctly', () {
      final exception = AuthException.tokenExpired('Custom message');

      expect(exception.type, AuthExceptionType.tokenExpired);
      expect(exception.message, 'Custom message');
    });

    test('ValidationException.field creates correct field error', () {
      final exception = ValidationException.field('email', '邮箱格式不正确');

      expect(exception.fieldErrors, {
        'email': ['邮箱格式不正确']
      });
      expect(exception.message, '邮箱格式不正确');
    });

    test('ValidationException.fields creates multiple field errors', () {
      final exception = ValidationException.fields({
        'email': ['邮箱格式不正确'],
        'password': ['密码太短', '需要包含数字'],
      });

      expect(exception.fieldErrors!.length, 2);
      expect(exception.fieldErrors!['password']!.length, 2);
    });

    test('NotFoundException.resource creates with type and id', () {
      final exception = NotFoundException.resource('User', '123');

      expect(exception.resourceType, 'User');
      expect(exception.resourceId, '123');
      expect(exception.message, 'User(id: 123)不存在');
    });
  });

  group('StorageException Tests', () {
    test('StorageException.readFailed should be retryable', () {
      final exception = StorageException.readFailed();

      expect(exception.type, StorageExceptionType.readFailed);
      expect(exception.isRetryable, true);
    });

    test('StorageException.notFound should not be retryable', () {
      final exception = StorageException.notFound();

      expect(exception.type, StorageExceptionType.notFound);
      expect(exception.isRetryable, false);
    });
  });

  group('ServiceException Tests', () {
    test('ServiceException.timeout should be retryable', () {
      final exception = ServiceException.timeout();

      expect(exception.type, ServiceExceptionType.timeout);
      expect(exception.isRetryable, true);
      expect(exception.userMessage, '请求超时，请检查网络后重试');
    });

    test('ServiceException.maintenance should not be retryable', () {
      final exception = ServiceException.maintenance();

      expect(exception.type, ServiceExceptionType.maintenance);
      expect(exception.isRetryable, false);
    });
  });

  group('ParseException Tests', () {
    test('ParseException.json creates correct exception', () {
      final exception = ParseException.json();

      expect(exception.code, 'PARSE_ERROR');
      expect(exception.message, 'JSON解析失败');
      expect(exception.userMessage, '数据格式错误');
    });
  });
}
