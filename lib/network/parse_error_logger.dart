import 'package:dio/dio.dart';

import '../common/log/logger.dart';

/// 用于处理Retrofit请求中的错误日志
class ParseErrorLogger {
  /// 记录错误信息
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    Log.e('ParseError: $error', stackTrace);
  }
}
