import 'package:flutter_test/flutter_test.dart';
import 'package:liushui_app/common/network/config/http_config.dart';

void main() {
  group('HttpConfigBuilder Tests', () {
    test('should build config with required baseUrl', () {
      final config =
          HttpConfigBuilder().baseUrl('https://api.example.com').build();

      expect(config.baseUrl, 'https://api.example.com');
    });

    test('should throw when baseUrl is empty', () {
      expect(
        () => HttpConfigBuilder().baseUrl('').build(),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw when baseUrl is not set', () {
      expect(
        () => HttpConfigBuilder().build(),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should set default timeout values', () {
      final config =
          HttpConfigBuilder().baseUrl('https://api.example.com').build();

      expect(config.connectTimeout, 30000);
      expect(config.receiveTimeout, 30000);
      expect(config.sendTimeout, 30000);
    });

    test('should override timeout values', () {
      final config = HttpConfigBuilder()
          .baseUrl('https://api.example.com')
          .connectTimeout(10000)
          .receiveTimeout(20000)
          .sendTimeout(15000)
          .build();

      expect(config.connectTimeout, 10000);
      expect(config.receiveTimeout, 20000);
      expect(config.sendTimeout, 15000);
    });

    test('should add headers', () {
      final config = HttpConfigBuilder()
          .baseUrl('https://api.example.com')
          .addHeader('X-Custom-Header', 'value')
          .addHeader('Accept-Language', 'zh-CN')
          .build();

      expect(config.defaultHeaders['X-Custom-Header'], 'value');
      expect(config.defaultHeaders['Accept-Language'], 'zh-CN');
    });

    test('should set headers map', () {
      final config = HttpConfigBuilder()
          .baseUrl('https://api.example.com')
          .headers({'Authorization': 'Bearer token'}).build();

      expect(config.defaultHeaders['Authorization'], 'Bearer token');
    });

    test('should enable cache with custom settings', () {
      final config = HttpConfigBuilder()
          .baseUrl('https://api.example.com')
          .enableCache(
            maxCacheSize: 100 * 1024 * 1024,
            defaultCacheDuration: const Duration(minutes: 10),
          )
          .build();

      expect(config.cacheConfig?.enabled, true);
      expect(config.cacheConfig?.maxCacheSize, 100 * 1024 * 1024);
      expect(config.cacheConfig?.defaultCacheDuration,
          const Duration(minutes: 10));
    });

    test('should enable retry with custom settings', () {
      final config = HttpConfigBuilder()
          .baseUrl('https://api.example.com')
          .enableRetry(
            maxRetries: 5,
            initialDelay: const Duration(seconds: 2),
            backoffMultiplier: 3.0,
          )
          .build();

      expect(config.retryConfig?.maxRetries, 5);
      expect(config.retryConfig?.initialDelay, const Duration(seconds: 2));
      expect(config.retryConfig?.backoffMultiplier, 3.0);
    });

    test('should enable log with custom settings', () {
      final config = HttpConfigBuilder()
          .baseUrl('https://api.example.com')
          .enableLog(
            logLevel: LogLevel.debug,
            logRequestHeaders: false,
            logResponseBody: false,
          )
          .build();

      expect(config.logConfig?.enabled, true);
      expect(config.logConfig?.logLevel, LogLevel.debug);
      expect(config.logConfig?.logRequestHeaders, false);
      expect(config.logConfig?.logResponseBody, false);
    });

    test('toBuilder should create builder from existing config', () {
      final original = HttpConfigBuilder()
          .baseUrl('https://api.example.com')
          .connectTimeout(5000)
          .build();

      final modified = original.toBuilder().connectTimeout(10000).build();

      expect(modified.baseUrl, 'https://api.example.com');
      expect(modified.connectTimeout, 10000);
      expect(original.connectTimeout, 5000);
    });
  });

  group('CacheConfig Tests', () {
    test('should have correct default values', () {
      const config = CacheConfig();

      expect(config.enabled, true);
      expect(config.maxCacheSize, 50 * 1024 * 1024);
      expect(config.defaultCacheDuration, const Duration(minutes: 5));
      expect(config.cacheableMethods, ['GET']);
    });
  });

  group('RetryConfig Tests', () {
    test('should have correct default values', () {
      const config = RetryConfig();

      expect(config.maxRetries, 3);
      expect(config.initialDelay, const Duration(seconds: 1));
      expect(config.backoffMultiplier, 2.0);
      expect(config.maxDelay, const Duration(seconds: 30));
      expect(config.retryableStatusCodes, [408, 429, 500, 502, 503, 504]);
    });
  });
}
