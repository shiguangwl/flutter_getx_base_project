/// 错误上报接口
/// 实现此接口以对接不同的错误上报平台（Sentry、Bugly、Firebase等）
abstract class ErrorReporter {
  /// 上报错误
  Future<void> report({
    required dynamic error,
    required StackTrace stackTrace,
    required String source,
    String? context,
    Map<String, dynamic>? extra,
  });

  /// 设置用户信息（用于错误追踪）
  void setUser({String? id, String? email, String? name});

  /// 添加面包屑（用于错误上下文追踪）
  void addBreadcrumb(String message,
      {String? category, Map<String, dynamic>? data});

  /// 清除用户信息
  void clearUser();
}
