import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 键盘相关操作工具类
class KeyboardUtils {
  /// 隐藏键盘
  static void hideKeyboard([BuildContext? context]) {
    if (context != null) {
      FocusScope.of(context).unfocus();
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  /// 显示键盘
  static void showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// 检查键盘是否可见 - 需要传入 BuildContext
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// 清除输入焦点
  static void clearFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// 清除数据
  static void clearClientKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.clearClient');
  }
}
