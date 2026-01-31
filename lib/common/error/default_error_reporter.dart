import '../log/logger.dart';
import 'error_reporter.dart';

/// 默认错误上报实现
/// 将错误记录到本地日志，可扩展对接远程服务
class DefaultErrorReporter implements ErrorReporter {
  String? _userId;
  String? _userEmail;
  String? _userName;
  final List<_Breadcrumb> _breadcrumbs = [];
  static const int _maxBreadcrumbs = 50;

  @override
  Future<void> report({
    required dynamic error,
    required StackTrace stackTrace,
    required String source,
    String? context,
    Map<String, dynamic>? extra,
  }) async {
    final errorInfo = StringBuffer()
      ..writeln('========== Error Report ==========')
      ..writeln('Source: $source')
      ..writeln('Time: ${DateTime.now().toIso8601String()}')
      ..writeln('Error: $error')
      ..writeln('Type: ${error.runtimeType}');

    if (context != null) {
      errorInfo.writeln('Context: $context');
    }

    if (_userId != null || _userEmail != null || _userName != null) {
      errorInfo.writeln('User: $_userName ($_userId) <$_userEmail>');
    }

    if (extra != null && extra.isNotEmpty) {
      errorInfo.writeln('Extra: $extra');
    }

    if (_breadcrumbs.isNotEmpty) {
      errorInfo.writeln('Breadcrumbs:');
      for (final crumb in _breadcrumbs.reversed.take(10)) {
        errorInfo.writeln('  - [${crumb.category}] ${crumb.message}');
      }
    }

    errorInfo.writeln('Stack Trace:');
    errorInfo.writeln(stackTrace);
    errorInfo.writeln('===================================');

    Log.e(errorInfo.toString());

    // TODO: 扩展点 - 在此添加远程上报逻辑
    // 例如: await SentryService.captureException(error, stackTrace);
  }

  @override
  void setUser({String? id, String? email, String? name}) {
    _userId = id;
    _userEmail = email;
    _userName = name;
  }

  @override
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  }) {
    _breadcrumbs.add(_Breadcrumb(
      message: message,
      category: category ?? 'default',
      timestamp: DateTime.now(),
      data: data,
    ));

    if (_breadcrumbs.length > _maxBreadcrumbs) {
      _breadcrumbs.removeAt(0);
    }
  }

  @override
  void clearUser() {
    _userId = null;
    _userEmail = null;
    _userName = null;
  }
}

class _Breadcrumb {
  final String message;
  final String category;
  final DateTime timestamp;
  final Map<String, dynamic>? data;

  _Breadcrumb({
    required this.message,
    required this.category,
    required this.timestamp,
    this.data,
  });
}
