// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContainerExtension on Container {
  static final String img = "/assets/images/gradient_bg.png";

  /// 为 Container 添加渐变背景
  /// [height] 容器高度，默认为 279
  Container withGradientBackground({double? height}) {
    return Container(
      height: height ?? 279.h, // 使用 ScreenUtil 的高度适配
      width: this.constraints?.maxWidth ?? double.infinity,
      margin: this.margin,
      padding: this.padding,
      alignment: this.alignment,
      transform: this.transform,
      transformAlignment: this.transformAlignment,
      clipBehavior: this.clipBehavior,
      decoration: BoxDecoration(
        // 添加渐变背景
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ],
        ),
        // 保持原有的装饰属性（如果有的话）
        borderRadius: this.decoration is BoxDecoration
            ? (this.decoration as BoxDecoration).borderRadius
            : null,
        boxShadow: this.decoration is BoxDecoration
            ? (this.decoration as BoxDecoration).boxShadow
            : null,
        // 添加背景图片（如果需要的话）
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: this.child,
    );
  }
}
