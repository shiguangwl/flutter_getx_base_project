import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'request_race_guard.dart';

/// GetxController 竞态请求混入
///
/// 提供便捷的竞态请求处理能力，自动管理生命周期
mixin RaceGuardMixin on GetxController {
  final RequestRaceGuard _defaultGuard = RequestRaceGuard();
  final MultiRequestRaceGuard _multiGuard = MultiRequestRaceGuard();

  /// 默认守卫（单一请求场景）
  RequestRaceGuard get raceGuard => _defaultGuard;

  /// 多请求组守卫（多独立请求场景）
  MultiRequestRaceGuard get multiRaceGuard => _multiGuard;

  /// 快捷方法：执行带竞态保护的请求
  Future<T?> guardedRequest<T>({
    required Future<T> Function(CancelToken token) request,
    required void Function(T data) onSuccess,
    void Function(dynamic error)? onError,
  }) {
    return _defaultGuard.guard(
      request: request,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// 快捷方法：执行带竞态保护的请求（无 CancelToken 版本）
  Future<T?> guardedRequestSimple<T>({
    required Future<T> Function() request,
    required void Function(T data) onSuccess,
    void Function(dynamic error)? onError,
  }) {
    return _defaultGuard.guardWithoutCancel(
      request: request,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  @override
  void onClose() {
    _defaultGuard.dispose();
    _multiGuard.dispose();
    super.onClose();
  }
}
