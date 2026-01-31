import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 应用颜色方案 - 作为 ThemeExtension 注入到 ThemeData
/// - Context 访问：context.appColors.primary
class AppColors extends ThemeExtension<AppColors> {
  static AppColors get of {
    final ctx = Get.context;
    assert(ctx != null, 'Get.context is null, ensure GetMaterialApp is used');
    return Theme.of(ctx!).extension<AppColors>()!;
  }

  /// 主品牌色。用于 AppBar 导航栏背景、主操作按钮（ElevatedButton）、主要功能组件背景。
  final Color primary;

  /// 基于主品牌色的对比色。用于 AppBar 上的标题文字、主操作按钮内的文字或图标。
  final Color onPrimary;

  /// 主品牌色浅色变体。用于主色调下的渐变填充、悬停状态（Hover）或选中的背景高亮。
  final Color primaryLight;

  /// 主品牌色深色变体。用于按下状态（Pressed）的视觉反馈或具有深色倾向的装饰性元素。
  final Color primaryDark;

  /// 次要品牌色（装饰/强调色）。用于悬浮按钮（FAB）、进度条（ProgressIndicator）或开关（Switch）的激活态。
  final Color secondary;

  /// 基础背景色。用于 Scaffold 的 backgroundColor，即页面的最底层视觉基准面。
  final Color background;

  /// 表面颜色。用于 Dialog 弹窗、BottomSheet 底部抽屉、Menu 菜单的底层容器。
  final Color surface;

  /// 卡片色。用于 Card 组件或具有物理阴影层级感的列表项背景。
  final Color card;

  /// 遮罩颜色。用于 ModalBarrier、弹窗背景半透明遮罩或图片上的文字蒙层。
  final Color overlay;

  /// 输入框填充色。用于 TextField 的 decoration 中 filled 属性开启后的背景填充。
  final Color inputFill;

  /// 一级文本。用于主要标题、正文文本，具有最高文本对比度。
  final Color textPrimary;

  /// 二级文本。用于副标题、描述性文字或列表摘要。
  final Color textSecondary;

  /// 三级文本。用于辅助说明、脚注、时间戳或占位符（Placeholder）。
  final Color textTertiary;

  /// 禁用文本。用于已禁用按钮（Disabled Button）或不可编辑输入框的文本显示。
  final Color textDisabled;

  /// 边框颜色。用于 Container 的 Border、TextField 的启用边框（EnabledBorder）或组件外轮廓。
  final Color border;

  /// 分割线颜色。用于 Divider、VerticalDivider 组件或列表项之间的物理分隔。
  final Color divider;

  /// 图标颜色。用于 ListTile 的 leading/trailing 或独立的静态 Icon。
  final Color icon;

  /// 激活态图标颜色。用于 BottomNavigationBar 选中项、激活态的 Checkbox 指示器。
  final Color iconActive;

  /// 成功色。用于表示操作成功（SnackBar）、表单校验通过、状态正常。
  final Color success;

  /// 警告色。用于提示潜在风险、中间状态提示或需要用户关注的异常。
  final Color warning;

  /// 错误色。用于表单错误提示文字（ErrorText）、删除操作确认、系统故障警告。
  final Color error;

  /// 信息色。用于中性的提示信息、详情引导或一般性的系统通知。
  final Color info;

  const AppColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryLight,
    required this.primaryDark,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.card,
    required this.overlay,
    required this.inputFill,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.border,
    required this.divider,
    required this.icon,
    required this.iconActive,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryLight,
    Color? primaryDark,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? card,
    Color? overlay,
    Color? inputFill,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? border,
    Color? divider,
    Color? icon,
    Color? iconActive,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      overlay: overlay ?? this.overlay,
      inputFill: inputFill ?? this.inputFill,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      icon: icon ?? this.icon,
      iconActive: iconActive ?? this.iconActive,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      iconActive: Color.lerp(iconActive, other.iconActive, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
