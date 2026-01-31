import 'package:flutter/material.dart';

/// 对话框配置模型
class DialogConfig {
  final String? title;
  final String? content;
  final Widget? contentWidget;
  final bool barrierDismissible;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? actionsPadding;

  const DialogConfig({
    this.title,
    this.content,
    this.contentWidget,
    this.barrierDismissible = true,
    this.titleStyle,
    this.contentStyle,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.contentPadding,
    this.actionsPadding,
  });
}
