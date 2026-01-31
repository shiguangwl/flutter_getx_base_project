/// 分析事件接口
abstract class AnalyticsEvent {
  String get name;
  Map<String, dynamic>? get parameters;
}

/// 页面访问事件
class PageViewEvent implements AnalyticsEvent {
  @override
  final String name;
  final String? screenClass;

  const PageViewEvent({required this.name, this.screenClass});

  @override
  Map<String, dynamic>? get parameters => {
        if (screenClass != null) 'screen_class': screenClass,
      };
}

/// 自定义事件
class CustomEvent implements AnalyticsEvent {
  @override
  final String name;
  @override
  final Map<String, dynamic>? parameters;

  const CustomEvent({required this.name, this.parameters});
}

/// 用户属性事件
class UserPropertyEvent implements AnalyticsEvent {
  final String propertyName;
  final String? propertyValue;

  const UserPropertyEvent({
    required this.propertyName,
    this.propertyValue,
  });

  @override
  String get name => 'user_property';

  @override
  Map<String, dynamic>? get parameters => {
        'property_name': propertyName,
        'property_value': propertyValue,
      };
}
