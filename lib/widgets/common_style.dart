import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/theme/app_colors.dart';

class CommonStyle {
  CommonStyle._();

  static final BoxDecoration gradientBg = BoxDecoration(
    color: Theme.of(Get.context!).scaffoldBackgroundColor,
    image: const DecorationImage(
      image: AssetImage("assets/images/gradient_bg.png"),
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
    ),
  );

  /// 获取弱文本样式（动态响应主题）
  static TextStyle weakTextStyle() =>
      TextStyle(color: AppColors.of.textSecondary);

  /// 获取主色文本样式（动态响应主题）
  static TextStyle primaryTextStyle() => TextStyle(color: AppColors.of.primary);
}
