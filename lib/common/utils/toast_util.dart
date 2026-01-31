import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Toast工具类
class ToastUtil {
  const ToastUtil._internal();

  /// 显示Toast提示
  /// [message] 提示信息
  /// [gravity] 显示位置，默认底部
  /// [timeInSecForIosWeb] iOS和Web平台显示时长
  /// [backgroundColor] 背景颜色
  /// [textColor] 文字颜色
  /// [fontSize] 字体大小
  static void showToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 2,
    Color? backgroundColor,
    Color? textColor,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor ?? Colors.black54,
      textColor: textColor ?? Colors.white,
      fontSize: fontSize,
    );
  }

  /// 显示成功提示
  static void showSuccess(String message) {
    showToast(
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// 显示错误提示
  static void showError(String message) {
    showToast(
      message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  /// 显示警告提示
  static void showWarning(String message) {
    showToast(
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  /// 显示信息提示
  static void showInfo(String message) {
    showToast(
      message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  /// 取消所有Toast
  static void cancelAllToasts() {
    // GetX 的 Snackbar 会自动管理
  }
}
