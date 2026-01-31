import 'package:flutter/foundation.dart';

import 'env_type.dart';

/// 编译时环境配置
/// 用法: flutter run --dart-define-from-file=env/dev.json
abstract final class Env {
  // ─────────────────── 配置项（新增只需加一行）───────────────────
  static const apiUrl = String.fromEnvironment('API_URL');
  static const clientId = String.fromEnvironment('CLIENT_ID');
  static const tenantId = String.fromEnvironment('TENANT_ID');
  static const debugLog = bool.fromEnvironment('DEBUG_LOG');
  static const perfMonitor = bool.fromEnvironment('PERF_MONITOR');
  static const appVersion = String.fromEnvironment('APP_VERSION');

  // ─────────────────── 环境类型 ───────────────────
  static const _env = String.fromEnvironment('ENV', defaultValue: 'dev');
  static EnvType get type => EnvType.fromString(_env);
  static bool get isDev => type.isDev;
  static bool get isTest => type.isTest;
  static bool get isProd => type.isProd;
  static bool get isDebug => type.isDebugMode || kDebugMode;
}
