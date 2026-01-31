import 'package:dio/dio.dart';
import '../config/http_config.dart';

/// 缓存拦截器 - 移除单例模式
class CacheInterceptor extends Interceptor {
  final CacheConfig? _config;
  final Map<String, _CacheItem> _cache = {};

  CacheInterceptor(this._config);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_config?.enabled != true || !_isCacheable(options)) {
      handler.next(options);
      return;
    }

    final cacheKey = _generateCacheKey(options);
    final cachedItem = _cache[cacheKey];

    if (cachedItem != null && !cachedItem.isExpired) {
      // 返回缓存的响应
      final response = Response<dynamic>(
        data: cachedItem.data,
        statusCode: 200,
        requestOptions: options,
        headers: Headers.fromMap(cachedItem.headers),
      );
      handler.resolve(response);
      return;
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_config?.enabled == true &&
        _isCacheable(response.requestOptions) &&
        response.statusCode == 200) {
      final cacheKey = _generateCacheKey(response.requestOptions);
      final duration = _getCacheDuration(response.requestOptions);

      _cache[cacheKey] = _CacheItem(
        data: response.data,
        headers: response.headers.map,
        expireTime: DateTime.now().add(duration),
      );

      // 清理过期缓存
      _cleanExpiredCache();
    }

    handler.next(response);
  }

  /// 检查请求是否可缓存
  bool _isCacheable(RequestOptions options) {
    return _config?.cacheableMethods.contains(options.method.toUpperCase()) ??
        false;
  }

  /// 生成缓存键
  String _generateCacheKey(RequestOptions options) {
    final uri = options.uri.toString();
    final method = options.method.toUpperCase();
    return '$method:$uri';
  }

  /// 获取缓存持续时间
  Duration _getCacheDuration(RequestOptions options) {
    // 可以根据请求头或配置来确定缓存时间
    final cacheControl = options.headers['Cache-Control'];
    if (cacheControl != null) {
      final maxAge =
          RegExp(r'max-age=(\d+)').firstMatch(cacheControl.toString());
      if (maxAge != null) {
        final group = maxAge.group(1);
        if (group != null) {
          return Duration(seconds: int.parse(group));
        }
      }
    }
    return _config?.defaultCacheDuration ?? const Duration(minutes: 5);
  }

  /// 清理过期缓存
  void _cleanExpiredCache() {
    _cache.removeWhere((key, item) => item.isExpired);

    // 如果缓存过大，移除最旧的条目
    if (_cache.length > 100) {
      final sortedEntries = _cache.entries.toList()
        ..sort((a, b) => a.value.expireTime.compareTo(b.value.expireTime));

      final toRemove = sortedEntries.take(_cache.length - 100);
      for (final entry in toRemove) {
        _cache.remove(entry.key);
      }
    }
  }

  /// 清空缓存
  void clearCache() {
    _cache.clear();
  }

  /// 移除指定缓存
  void removeCache(String pattern) {
    _cache.removeWhere((key, value) => key.contains(pattern));
  }
}

/// 缓存项
class _CacheItem {
  final dynamic data;
  final Map<String, List<String>> headers;
  final DateTime expireTime;

  _CacheItem({
    required this.data,
    required this.headers,
    required this.expireTime,
  });

  bool get isExpired => DateTime.now().isAfter(expireTime);
}
