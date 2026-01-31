import 'dart:math';

import 'package:flutter/material.dart';

/// 颜色相关操作工具类
class ColorUtil {
  const ColorUtil._();

  /// 将十六进制颜色字符串转换为Color对象
  static Color? hexToColor(String hex) {
    if (hex.isEmpty) return null;
    try {
      String colorStr = hex.replaceFirst('#', '');
      if (colorStr.length == 6) {
        colorStr = 'FF$colorStr';
      }
      return Color(int.parse(colorStr, radix: 16));
    } catch (e) {
      return null;
    }
  }

  /// 生成随机颜色
  static Color randomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  /// 判断颜色是否为亮色
  static bool isLightColor(Color color) {
    final hslColor = HSLColor.fromColor(color);
    return hslColor.lightness > 0.5;
  }

  /// 获取对比色（亮色返回黑色，暗色返回白色）
  static Color contrastColor(Color color) {
    return isLightColor(color) ? Colors.black : Colors.white;
  }
}

/// 保持向后兼容
@Deprecated('Use ColorUtil instead')
typedef ColorUtils = ColorUtil;
