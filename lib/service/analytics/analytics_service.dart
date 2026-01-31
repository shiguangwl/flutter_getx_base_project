import 'package:get/get.dart';

import 'analytics_event.dart';
import 'analytics_provider.dart';

/// 分析服务
/// 统一管理所有分析平台，支持多平台同时上报
class AnalyticsService extends GetxService {
  static AnalyticsService get to => Get.find<AnalyticsService>();

  final List<AnalyticsProvider> _providers = [];
  bool _initialized = false;

  /// 注册分析提供者
  void registerProvider(AnalyticsProvider provider) {
    _providers.add(provider);
  }

  /// 初始化所有分析提供者
  Future<void> initialize() async {
    if (_initialized) return;

    for (final provider in _providers) {
      await provider.init();
    }
    _initialized = true;
  }

  /// 记录事件
  Future<void> logEvent(AnalyticsEvent event) async {
    for (final provider in _providers) {
      await provider.logEvent(event);
    }
  }

  /// 记录自定义事件
  Future<void> log(String name, [Map<String, dynamic>? params]) async {
    await logEvent(CustomEvent(name: name, parameters: params));
  }

  /// 记录页面访问
  Future<void> logPageView(String pageName, {String? screenClass}) async {
    for (final provider in _providers) {
      await provider.logPageView(pageName, screenClass: screenClass);
    }
  }

  /// 设置用户ID
  Future<void> setUserId(String? userId) async {
    for (final provider in _providers) {
      await provider.setUserId(userId);
    }
  }

  /// 设置用户属性
  Future<void> setUserProperty(String name, String? value) async {
    for (final provider in _providers) {
      await provider.setUserProperty(name, value);
    }
  }

  /// 重置分析数据（用于用户登出）
  Future<void> reset() async {
    for (final provider in _providers) {
      await provider.reset();
    }
  }

  /// 按钮点击事件
  Future<void> logButtonClick(String buttonName, {String? screen}) async {
    await log('button_click', {
      'button_name': buttonName,
      if (screen != null) 'screen': screen,
    });
  }

  /// 搜索事件
  Future<void> logSearch(String query) async {
    await log('search', {'query': query});
  }

  /// 分享事件
  Future<void> logShare(String contentType, String itemId) async {
    await log('share', {
      'content_type': contentType,
      'item_id': itemId,
    });
  }

  /// 登录事件
  Future<void> logLogin(String method) async {
    await log('login', {'method': method});
  }

  /// 注册事件
  Future<void> logSignUp(String method) async {
    await log('sign_up', {'method': method});
  }
}
