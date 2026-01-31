/// 页面状态枚举
enum PageState { loading, success, error, empty }

/// 页面加载结果
sealed class PageResult {
  static const PageResult success = PageSuccess();
  static const PageResult empty = PageEmpty();
  static const PageResult failure = PageFailure(PageError.unknownError);
  const PageResult();
}

class PageSuccess extends PageResult {
  const PageSuccess();
}

class PageEmpty extends PageResult {
  final String? message;
  const PageEmpty([this.message]);
}

class PageFailure extends PageResult {
  final PageError error;
  const PageFailure(this.error);
}

/// 错误类型枚举
enum ErrorType {
  network, // 网络错误
  noNetwork, // 无网络连接
  server, // 服务器错误
  timeout, // 请求超时
  permission, // 权限错误
  location, // 位置错误
  unknown, // 未知错误
}

/// 错误信息类
class PageError {
  final ErrorType type;
  final String message;
  final dynamic originalError;

  const PageError({
    required this.type,
    required this.message,
    this.originalError,
  });

  /// 预定义的常用错误
  static const PageError networkError = PageError(
    type: ErrorType.network,
    message: '网络连接异常，请检查网络设置',
  );

  static const PageError noNetworkError = PageError(
    type: ErrorType.noNetwork,
    message: '无网络连接，请检查网络设置',
  );

  static const PageError serverError = PageError(
    type: ErrorType.server,
    message: '服务器异常，请稍后重试',
  );

  static const PageError timeoutError = PageError(
    type: ErrorType.timeout,
    message: '请求超时，请稍后重试',
  );

  static const PageError unknownError = PageError(
    type: ErrorType.unknown,
    message: '未知错误，请稍后重试',
  );

  static const PageError permissionError = PageError(
    type: ErrorType.permission,
    message: '权限错误',
  );
}
