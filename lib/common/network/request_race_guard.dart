import 'package:dio/dio.dart';

/// 请求竞态守卫 - 解决快速切换条件导致的数据错乱问题
///
/// 使用场景：分类切换、筛选条件变更、搜索等需要取消旧请求的场景
class RequestRaceGuard {
  CancelToken? _cancelToken;
  int _requestVersion = 0;

  /// 当前请求版本号
  int get currentVersion => _requestVersion;

  /// 是否有正在进行的请求
  bool get hasPendingRequest =>
      _cancelToken != null && !_cancelToken!.isCancelled;

  /// 获取新的 CancelToken（自动取消上一个）
  CancelToken getNewToken() {
    cancel();
    _cancelToken = CancelToken();
    _requestVersion++;
    return _cancelToken!;
  }

  /// 取消当前请求
  void cancel([String reason = '新请求取消旧请求']) {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel(reason);
    }
    _cancelToken = null;
  }

  /// 检查版本号是否是最新的
  bool isLatest(int version) => version == _requestVersion;

  /// 包装异步请求，自动处理竞态
  ///
  /// [request] 实际的请求函数，接收 CancelToken 和版本号
  /// [onSuccess] 请求成功且是最新版本时的回调
  /// [onError] 请求失败时的回调（已过滤掉取消异常）
  Future<T?> guard<T>({
    required Future<T> Function(CancelToken token) request,
    required void Function(T data) onSuccess,
    void Function(dynamic error)? onError,
  }) async {
    final token = getNewToken();
    final version = _requestVersion;

    try {
      final result = await request(token);
      if (!isLatest(version)) return null;
      onSuccess(result);
      return result;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return null;
      if (!isLatest(version)) return null;
      onError?.call(e);
      rethrow;
    } catch (e) {
      if (!isLatest(version)) return null;
      onError?.call(e);
      rethrow;
    }
  }

  /// 包装不支持 CancelToken 的请求（如 Retrofit 方法）
  /// 仅使用版本号校验，无法取消请求
  Future<T?> guardWithoutCancel<T>({
    required Future<T> Function() request,
    required void Function(T data) onSuccess,
    void Function(dynamic error)? onError,
  }) async {
    cancel();
    final version = ++_requestVersion;

    try {
      final result = await request();
      if (!isLatest(version)) return null;
      onSuccess(result);
      return result;
    } catch (e) {
      if (!isLatest(version)) return null;
      onError?.call(e);
      rethrow;
    }
  }

  /// 释放资源
  void dispose() {
    cancel('dispose');
    _requestVersion = 0;
  }
}

/// 多请求组竞态守卫 - 管理多个独立的请求组
///
/// 使用场景：一个页面有多个独立的筛选区域，各自需要独立的竞态控制
class MultiRequestRaceGuard {
  final Map<String, RequestRaceGuard> _guards = {};

  /// 获取指定 key 的守卫（不存在则自动创建）
  RequestRaceGuard operator [](String key) {
    return _guards.putIfAbsent(key, () => RequestRaceGuard());
  }

  /// 取消指定 key 的请求
  void cancel(String key, [String reason = '取消请求']) {
    _guards[key]?.cancel(reason);
  }

  /// 取消所有请求
  void cancelAll([String reason = '取消所有请求']) {
    for (final guard in _guards.values) {
      guard.cancel(reason);
    }
  }

  /// 移除指定 key 的守卫
  void remove(String key) {
    _guards[key]?.dispose();
    _guards.remove(key);
  }

  /// 释放所有资源
  void dispose() {
    for (final guard in _guards.values) {
      guard.dispose();
    }
    _guards.clear();
  }
}
