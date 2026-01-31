import 'package:flutter/material.dart';

import 'app_colors.dart';

/// BuildContext 扩展 - 便捷获取主题颜色
extension ThemeContextExtension on BuildContext {
  /// 获取当前主题的 AppColors
  /// 使用方式: context.appColors.primary
  AppColors get appColors {
    final colors = Theme.of(this).extension<AppColors>();
    assert(colors != null, 'AppColors not found in ThemeData.extensions');
    return colors!;
  }

  /// 获取当前主题的 TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// 获取当前主题的 ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// 判断当前是否为暗色主题
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
