import 'package:flutter/material.dart';

/// 对话框按钮模型
class DialogButton {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final bool isPrimary;

  const DialogButton({
    required this.text,
    this.onPressed,
    this.style,
    this.textStyle,
    this.isPrimary = false,
  });
}
