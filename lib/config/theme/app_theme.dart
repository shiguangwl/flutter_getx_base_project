/// 应用主题枚举
/// 支持多主题扩展，新增主题只需添加枚举值
enum AppTheme {
  light,
  dark,
  purple,
  blue,
  ;

  String get label {
    switch (this) {
      case AppTheme.light:
        return '浅色模式';
      case AppTheme.dark:
        return '深色模式';
      case AppTheme.purple:
        return '紫色主题';
      case AppTheme.blue:
        return '蓝色主题';
    }
  }

  bool get isDark {
    switch (this) {
      case AppTheme.dark:
        return true;
      default:
        return false;
    }
  }
}
