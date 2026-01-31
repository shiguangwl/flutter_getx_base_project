import 'package:flutter_test/flutter_test.dart';
import 'package:liushui_app/common/network/exception/network_exception.dart';

void main() {
  group('NetworkException Tests', () {
    test('NetworkException.network creates correct exception', () {
      final exception = NetworkException.network();

      expect(exception.code, -1001);
      expect(exception.exceptionType, NetworkExceptionType.network);
      expect(exception.isNetworkError, true);
      expect(exception.userFriendlyMessage, '网络连接失败，请检查网络设置');
    });

    test('NetworkException.timeout creates correct exception', () {
      final exception = NetworkException.timeout();

      expect(exception.code, -1002);
      expect(exception.exceptionType, NetworkExceptionType.timeout);
      expect(exception.isTimeoutError, true);
      expect(exception.userFriendlyMessage, '请求超时，请稍后重试');
    });

    test('NetworkException.httpError for 401', () {
      final exception = NetworkException.httpError(code: 401);

      expect(exception.code, 401);
      expect(exception.isHttpError, true);
      expect(exception.isClientError, true);
      expect(exception.userFriendlyMessage, '身份验证失败，请重新登录');
    });

    test('NetworkException.httpError for 500', () {
      final exception = NetworkException.httpError(code: 500);

      expect(exception.code, 500);
      expect(exception.isServerError, true);
      expect(exception.userFriendlyMessage, '服务器内部错误');
    });

    test('NetworkException.httpError for 503', () {
      final exception = NetworkException.httpError(code: 503);

      expect(exception.code, 503);
      expect(exception.isServerError, true);
      expect(exception.userFriendlyMessage, '服务暂时不可用');
    });

    test('NetworkException.cancel creates correct exception', () {
      final exception = NetworkException.cancel();

      expect(exception.code, -1003);
      expect(exception.isCancelError, true);
      expect(exception.userFriendlyMessage, '请求已取消');
    });

    test('NetworkException.parse creates correct exception', () {
      final exception = NetworkException.parse();

      expect(exception.code, -1004);
      expect(exception.isParseError, true);
      expect(exception.userFriendlyMessage, '数据格式错误');
    });

    test('NetworkException.unknown creates correct exception', () {
      final exception = NetworkException.unknown();

      expect(exception.code, -1000);
      expect(exception.isUnknownError, true);
      expect(exception.userFriendlyMessage, '未知错误，请稍后重试');
    });

    test('NetworkException equality works correctly', () {
      final e1 = NetworkException.network(message: 'Test');
      final e2 = NetworkException.network(message: 'Test');
      final e3 = NetworkException.timeout();

      expect(e1, equals(e2));
      expect(e1, isNot(equals(e3)));
    });

    test('NetworkException toString contains all info', () {
      final exception = NetworkException.httpError(code: 404);
      final str = exception.toString();

      expect(str, contains('404'));
      expect(str, contains('NetworkException'));
      expect(str, contains('httpError'));
    });
  });

  group('NetworkException HTTP Status Codes', () {
    final statusMessages = {
      400: '请求参数错误',
      403: '没有访问权限',
      404: '请求的资源不存在',
      429: '请求过于频繁，请稍后重试',
      502: '网关错误',
      504: '网关超时',
    };

    for (final entry in statusMessages.entries) {
      test('HTTP ${entry.key} returns "${entry.value}"', () {
        final exception = NetworkException.httpError(code: entry.key);
        expect(exception.userFriendlyMessage, entry.value);
      });
    }
  });
}
