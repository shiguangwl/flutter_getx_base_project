import 'package:flutter/material.dart';

import 'dialog_button.dart';
import 'dialog_config.dart';

/// 对话框构建器 - 内部使用
class DialogBuilder {
  const DialogBuilder._();

  static const _defaultBoxShadow = [
    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
  ];

  /// 构建自定义对话框
  static Widget build({
    required DialogConfig config,
    String? title,
    String? content,
    Widget? contentWidget,
    required List<DialogButton> buttons,
  }) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: config.backgroundColor ?? Colors.white,
          borderRadius: config.borderRadius ?? BorderRadius.circular(12),
          boxShadow: config.boxShadow ?? _defaultBoxShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                padding: config.contentPadding ?? const EdgeInsets.all(20),
                child: Text(
                  title,
                  style: config.titleStyle ??
                      const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            if (content != null || contentWidget != null)
              Padding(
                padding: config.contentPadding ??
                    EdgeInsets.fromLTRB(20, title != null ? 0 : 20, 20, 20),
                child: contentWidget ??
                    Text(
                      content!,
                      style: config.contentStyle ??
                          const TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
              ),
            if (buttons.isNotEmpty)
              Container(
                padding: config.actionsPadding ??
                    const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: buttons.length == 1
                    ? _buildSingleButton(buttons.first)
                    : _buildMultipleButtons(buttons),
              ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSingleButton(DialogButton button) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: button.onPressed,
        style: button.style,
        child: Text(button.text, style: button.textStyle),
      ),
    );
  }

  static Widget _buildMultipleButtons(List<DialogButton> buttons) {
    if (buttons.length == 2) {
      return Row(
        children: [
          Expanded(child: _buildButtonItem(buttons[0])),
          const SizedBox(width: 12),
          Expanded(child: _buildButtonItem(buttons[1])),
        ],
      );
    }
    return Column(
      children: buttons.asMap().entries.map((entry) {
        return Padding(
          padding: EdgeInsets.only(top: entry.key > 0 ? 8 : 0),
          child: _buildButtonItem(entry.value),
        );
      }).toList(),
    );
  }

  static Widget _buildButtonItem(DialogButton button) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: button.onPressed,
        style: button.style,
        child: Text(button.text, style: button.textStyle),
      ),
    );
  }
}
