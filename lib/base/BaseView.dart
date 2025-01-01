import 'package:flutter/material.dart';
import 'package:flutter_getx_base_project/base/BaseController.dart';
import 'package:flutter_getx_base_project/base/loadState/page_status_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../config/them_config.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  BaseView({super.key});

  /// 状态栏高度
  final double statusBarH = ScreenUtil().statusBarHeight;

  /// 导航栏高度
  final double navBarH = AppBar().preferredSize.height;

  /// 安全区域高度
  final double safeBarH = ScreenUtil().bottomBarHeight;

  /// 是否构建Scaffold(默认false,通常只有需要导航栏的页面才需要构建)
  bool isScaffold() => false;

  T get logic => controller;

  /// 构建主视图内容
  Widget buildContent(BuildContext context);

  /// 构建Scaffold
  Widget buildScaffold(BuildContext context) {
    Widget contentView = GetBuilder<T>(
      init: logic,
      builder: (controller) => PageStatusWidget(
        logic: controller,
        childBuilder: () => buildContent(context),
      ),
    );

    return isScaffold() 
      ? Scaffold(
          appBar: AppBar(),
          body: contentView,
        ) 
      : contentView;
  }

  @override
  Widget build(BuildContext context) {
    _initScreenUtil(context);
    return buildScaffold(context);
  }

  /// 初始化屏幕适配工具
  void _initScreenUtil(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenUtil = ScreenUtil();

    if (orientation == Orientation.portrait &&
        !_isPortraitInitialized(screenUtil)) {
      ScreenUtil.init(context, designSize: portraitDesignSize);
    } else if (orientation == Orientation.landscape &&
        !_isLandscapeInitialized(screenUtil)) {
      ScreenUtil.init(context, designSize: landscapeDesignSize);
    }
  }

  bool _isPortraitInitialized(ScreenUtil screenUtil) {
    return screenUtil.screenWidth == portraitDesignSize.width &&
        screenUtil.screenHeight == portraitDesignSize.height;
  }

  bool _isLandscapeInitialized(ScreenUtil screenUtil) {
    return screenUtil.screenWidth == landscapeDesignSize.width &&
        screenUtil.screenHeight == landscapeDesignSize.height;
  }
}