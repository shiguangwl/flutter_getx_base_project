/// Token提供者接口
/// 1. 当Token失效时,自动调用 refreshToken() 方法进行刷新
/// 2. 刷新成功后，重新调用 getToken() 获取新的有效Token
/// 3. 如果 refreshToken() 返回空值，表示刷新失败，会触发 onRefreshTokenFailed() 回调
abstract class TokenProvider {
  // 获取 Token
  Future<String?> getToken();
  // 刷新 Token
  Future<void> refreshToken();
  // 刷新 Token 失败回调
  void onRefreshTokenFailed(dynamic info);
}

/// 网络错误处理器接口(错误通知)
abstract class ErrorHandler {
  void onError(dynamic error);
}

/// HTTP 配置类
class HttpConfig {
  final String baseUrl;
  final int connectTimeout;
  final int receiveTimeout;
  final int sendTimeout;
  final Map<String, String> defaultHeaders;
  final CacheConfig? cacheConfig;
  final RetryConfig? retryConfig;
  final LogConfig? logConfig;
  final TokenProvider? tokenProvider;
  final ErrorHandler? errorHandler;
  final ApiErrorConfig? apiErrorConfig;

  const HttpConfig._({
    required this.baseUrl,
    this.connectTimeout = 30000,
    this.receiveTimeout = 30000,
    this.sendTimeout = 30000,
    this.defaultHeaders = const {},
    this.cacheConfig = const CacheConfig(),
    this.retryConfig = const RetryConfig(),
    this.logConfig = const LogConfig(),
    this.tokenProvider,
    this.errorHandler,
    this.apiErrorConfig = const ApiErrorConfig(),
  });

  HttpConfigBuilder toBuilder() {
    return HttpConfigBuilder._fromConfig(this);
  }
}

/// 缓存配置
class CacheConfig {
  final bool enabled;
  final int maxCacheSize;
  final Duration defaultCacheDuration;
  final List<String> cacheableMethods;

  const CacheConfig({
    this.enabled = true,
    this.maxCacheSize = 50 * 1024 * 1024, // 50MB
    this.defaultCacheDuration = const Duration(minutes: 5),
    this.cacheableMethods = const ['GET'],
  });
}

/// 重试配置
class RetryConfig {
  final int maxRetries;
  final Duration initialDelay;
  final double backoffMultiplier;
  final Duration maxDelay;
  final List<int> retryableStatusCodes;

  const RetryConfig({
    this.maxRetries = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.backoffMultiplier = 2.0,
    this.maxDelay = const Duration(seconds: 30),
    this.retryableStatusCodes = const [408, 429, 500, 502, 503, 504],
  });
}

/// 日志配置
class LogConfig {
  final bool enabled;
  final LogLevel logLevel;
  final bool logRequestHeaders;
  final bool logRequestBody;
  final bool logResponseHeaders;
  final bool logResponseBody;

  const LogConfig({
    this.enabled = true,
    this.logLevel = LogLevel.info,
    this.logRequestHeaders = true,
    this.logRequestBody = true,
    this.logResponseHeaders = true,
    this.logResponseBody = true,
  });
}

// API错误配置
class ApiErrorConfig {
  final bool enabled;

  const ApiErrorConfig({
    this.enabled = true,
  });
}

/// 日志级别
enum LogLevel {
  none,
  error,
  warning,
  info,
  debug,
  verbose,
}

/// 配置构造器
class HttpConfigBuilder {
  String? _baseUrl;
  int _connectTimeout = 30000;
  int _receiveTimeout = 30000;
  int _sendTimeout = 30000;
  Map<String, String> _defaultHeaders = {};
  TokenProvider? _tokenProvider;
  ErrorHandler? _errorHandler;
  CacheConfig? _cacheConfig;
  RetryConfig? _retryConfig;
  LogConfig? _logConfig = const LogConfig();
  ApiErrorConfig? _apiErrorConfig = const ApiErrorConfig();

  HttpConfigBuilder();

  HttpConfigBuilder._fromConfig(HttpConfig config) {
    _baseUrl = config.baseUrl;
    _connectTimeout = config.connectTimeout;
    _receiveTimeout = config.receiveTimeout;
    _sendTimeout = config.sendTimeout;
    _defaultHeaders = Map.from(config.defaultHeaders);
    _tokenProvider = config.tokenProvider;
    _errorHandler = config.errorHandler;
    _cacheConfig = config.cacheConfig;
    _retryConfig = config.retryConfig;
    _logConfig = config.logConfig;
    _apiErrorConfig = config.apiErrorConfig;
  }

  /// 设置基础URL
  HttpConfigBuilder baseUrl(String url) {
    _baseUrl = url;
    return this;
  }

  /// 设置连接超时
  HttpConfigBuilder connectTimeout(int timeout) {
    _connectTimeout = timeout;
    return this;
  }

  /// 设置接收超时
  HttpConfigBuilder receiveTimeout(int timeout) {
    _receiveTimeout = timeout;
    return this;
  }

  /// 设置发送超时
  HttpConfigBuilder sendTimeout(int timeout) {
    _sendTimeout = timeout;
    return this;
  }

  /// 添加默认请求头
  HttpConfigBuilder addHeader(String key, String value) {
    _defaultHeaders[key] = value;
    return this;
  }

  /// 设置默认请求头
  HttpConfigBuilder headers(Map<String, String> headers) {
    _defaultHeaders = headers;
    return this;
  }

  /// 设置Token提供者
  HttpConfigBuilder tokenProvider(TokenProvider provider) {
    _tokenProvider = provider;
    return this;
  }

  /// 设置错误处理器
  HttpConfigBuilder errorHandler(ErrorHandler handler) {
    _errorHandler = handler;
    return this;
  }

  /// 设置缓存配置
  HttpConfigBuilder cacheConfig(CacheConfig config) {
    _cacheConfig = config;
    return this;
  }

  /// 设置重试配置
  HttpConfigBuilder retryConfig(RetryConfig config) {
    _retryConfig = config;
    return this;
  }

  /// 设置日志配置
  HttpConfigBuilder logConfig(LogConfig config) {
    _logConfig = config;
    return this;
  }

  /// 启用缓存
  HttpConfigBuilder enableCache({
    int maxCacheSize = 50 * 1024 * 1024,
    Duration defaultCacheDuration = const Duration(minutes: 5),
  }) {
    _cacheConfig = CacheConfig(
      enabled: true,
      maxCacheSize: maxCacheSize,
      defaultCacheDuration: defaultCacheDuration,
    );
    return this;
  }

  /// 启用重试
  HttpConfigBuilder enableRetry({
    int maxRetries = 3,
    Duration initialDelay = const Duration(seconds: 1),
    double backoffMultiplier = 2.0,
  }) {
    _retryConfig = RetryConfig(
      maxRetries: maxRetries,
      initialDelay: initialDelay,
      backoffMultiplier: backoffMultiplier,
    );
    return this;
  }

  /// 启用日志
  HttpConfigBuilder enableLog({
    LogLevel logLevel = LogLevel.info,
    bool logRequestHeaders = true,
    bool logRequestBody = true,
    bool logResponseHeaders = true,
    bool logResponseBody = true,
  }) {
    _logConfig = LogConfig(
      enabled: true,
      logLevel: logLevel,
      logRequestHeaders: logRequestHeaders,
      logRequestBody: logRequestBody,
      logResponseHeaders: logResponseHeaders,
      logResponseBody: logResponseBody,
    );
    return this;
  }

  /// 设置API错误配置
  HttpConfigBuilder apiErrorConfig(ApiErrorConfig config) {
    _apiErrorConfig = config;
    return this;
  }

  /// 构建配置对象
  HttpConfig build() {
    if (_baseUrl == null || _baseUrl!.isEmpty) {
      throw ArgumentError('Base URL is required and cannot be empty');
    }

    return HttpConfig._(
      baseUrl: _baseUrl!,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      defaultHeaders: Map.unmodifiable(_defaultHeaders),
      tokenProvider: _tokenProvider,
      errorHandler: _errorHandler,
      cacheConfig: _cacheConfig,
      retryConfig: _retryConfig,
      logConfig: _logConfig,
      apiErrorConfig: _apiErrorConfig,
    );
  }
}
