import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'global_color.dart';

// 竖屏设计尺寸
const Size portraitDesignSize = Size(375, 812);
// 横屏设计尺寸
const Size landscapeDesignSize = Size(812, 375);

/// 高亮模式
ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: MyColors.bgColor,

    /// 图片颜色配置
    iconTheme: const IconThemeData(color: Colors.white),

    /// 分割线颜色
    dividerColor: const Color(0xFFF2F2F2),

    /// 全局字体样式配置
    // textTheme: TextTheme(
    //   bodyMedium: TextStyle(
    //       color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 18.sp),
    //   bodySmall: TextStyle(color: Colors.grey, fontSize: 14.sp),
    //   bodyLarge: TextStyle(
    //       color: MyColors.lightBlueGrey, fontSize: 14.sp, fontWeight: FontWeight.w400),
    // ),
    inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black),
        counterStyle: TextStyle(color: Colors.black),
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Colors.black)), // UnderlineInputBorder
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Colors.black))), // UnderlineInputBorder, InputDecorationT
    /// 导航栏样式配置
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white70,
        centerTitle: true,
        elevation: 1.0,
        titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black)), // TextStyle, AppBarTheme
    textButtonTheme: const TextButtonThemeData());




/// 暗黑模式
ThemeData darkTheme = ThemeData.dark().copyWith(

    /// 图片颜色配置
    iconTheme: const IconThemeData(color: Colors.white),

    /// 分割线颜色
    dividerColor: Colors.white,

    /// 全局字体样式配置
    textTheme: TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.sp),
      bodySmall: TextStyle(color: Colors.white54, fontSize: 14.sp),
      bodyLarge: TextStyle(
          color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w400),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black),
        counterStyle: TextStyle(color: Colors.black),
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Colors.black)), // UnderlineInputBorder
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Colors.black))), // UnderlineInputBorder, InputDecorationT
    /// 导航栏样式配置
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black54,
        centerTitle: true,
        elevation: 1.0,
        titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white)), // TextStyle, AppBarTheme
    textButtonTheme: const TextButtonThemeData());
