import 'analytics_event.dart';

/// 分析提供者接口
/// 实现此接口以集成不同的分析平台（Firebase、友盟、神策等）
abstract class AnalyticsProvider {
  /// 初始化分析服务
  Future<void> init();

  /// 记录事件
  Future<void> logEvent(AnalyticsEvent event);

  /// 记录页面访问
  Future<void> logPageView(String pageName, {String? screenClass});

  /// 设置用户ID
  Future<void> setUserId(String? userId);

  /// 设置用户属性
  Future<void> setUserProperty(String name, String? value);

  /// 重置分析数据
  Future<void> reset();
}

/// 默认分析提供者（控制台日志）
class ConsoleAnalyticsProvider implements AnalyticsProvider {
  bool _enabled = true;

  @override
  Future<void> init() async {
    _log('Analytics initialized');
  }

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    _log('Event: ${event.name}, params: ${event.parameters}');
  }

  @override
  Future<void> logPageView(String pageName, {String? screenClass}) async {
    _log('PageView: $pageName, class: $screenClass');
  }

  @override
  Future<void> setUserId(String? userId) async {
    _log('UserId: $userId');
  }

  @override
  Future<void> setUserProperty(String name, String? value) async {
    _log('UserProperty: $name = $value');
  }

  @override
  Future<void> reset() async {
    _log('Analytics reset');
  }

  void setEnabled(bool enabled) => _enabled = enabled;

  void _log(String message) {
    if (_enabled) {
      // ignore: avoid_print
      print('[Analytics] $message');
    }
  }
}
