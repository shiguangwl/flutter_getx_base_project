import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'error_reporter.dart';

/// 全局异常捕获器
/// 统一捕获 Flutter、Dart、Isolate 层面的所有未处理异常
class ErrorCatcher {
  static ErrorReporter? _reporter;
  static bool _initialized = false;

  ErrorCatcher._();

  /// 初始化异常捕获
  static void init(ErrorReporter reporter) {
    if (_initialized) return;
    _reporter = reporter;
    _initialized = true;
    _setupFlutterErrorHandler();
    _setupPlatformDispatcherHandler();
    _setupIsolateErrorHandler();
  }

  /// 使用异常捕获包装运行应用
  static Future<void> run(FutureOr<void> Function() appRunner) async {
    await runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await appRunner();
      },
      (error, stackTrace) {
        _handleError(error, stackTrace, 'Zone');
      },
    );
  }

  /// Flutter 框架错误处理
  static void _setupFlutterErrorHandler() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      _handleError(
        details.exception,
        details.stack ?? StackTrace.current,
        'Flutter',
        context: details.context?.toString(),
      );
    };
  }

  /// Platform Dispatcher 错误处理（捕获渲染层错误）
  static void _setupPlatformDispatcherHandler() {
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      _handleError(error, stackTrace, 'Platform');
      return true;
    };
  }

  /// Isolate 错误处理
  static void _setupIsolateErrorHandler() {
    Isolate.current.addErrorListener(RawReceivePort((pair) {
      final List<dynamic> errorAndStacktrace = pair as List<dynamic>;
      final error = errorAndStacktrace[0];
      final stackTrace = errorAndStacktrace[1] is StackTrace
          ? errorAndStacktrace[1] as StackTrace
          : StackTrace.fromString(errorAndStacktrace[1].toString());
      _handleError(error, stackTrace, 'Isolate');
    }).sendPort);
  }

  /// 统一错误处理入口
  static void _handleError(
    dynamic error,
    StackTrace stackTrace,
    String source, {
    String? context,
  }) {
    if (kDebugMode) {
      debugPrint('[$source Error] $error');
      debugPrint('$stackTrace');
      if (context != null) debugPrint('Context: $context');
    }

    _reporter?.report(
      error: error,
      stackTrace: stackTrace,
      source: source,
      context: context,
    );
  }

  /// 手动上报错误
  static void reportError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
  }) {
    _handleError(
      error,
      stackTrace ?? StackTrace.current,
      'Manual',
      context: context,
    );
  }

  /// 包装异步操作，自动捕获错误
  static Future<T?> guard<T>(
    Future<T> Function() action, {
    T? fallback,
    String? context,
  }) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      _handleError(error, stackTrace, 'Guard', context: context);
      return fallback;
    }
  }
}
