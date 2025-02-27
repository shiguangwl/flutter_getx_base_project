import 'package:flutter/material.dart';
import 'package:lanyu_chat/base/BaseController.dart';
import 'package:lanyu_chat/base/loadState/page_status_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../config/them_config.dart';

/// 基础视图抽象类，提供通用的视图功能和状态管理
abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});

  /// 状态栏高度
  double get statusBarH => ScreenUtil().statusBarHeight;

  /// 导航栏高度
  double get navBarH => AppBar().preferredSize.height;

  /// 安全区域高度
  double get safeBarH => ScreenUtil().bottomBarHeight;

  /// 是否构建Scaffold(默认false,通常只有需要导航栏的页面才需要构建)
  bool isScaffold() => false;

  /// 控制器实例的便捷访问
  T get logic => controller;

  /// 构建主视图内容
  Widget buildContent(BuildContext context);

  /// 构建Scaffold（如果需要自定义Scaffold请重写当前方法）
  /// @param buildContent 构建的内容
  /// @return Scaffold
  Scaffold buildScaffold(Widget contentView) {
    return Scaffold(
      appBar: AppBar(),
      body: contentView,
    );
  }

  @override
  Widget build(BuildContext context) {
    _initScreenUtil(context);
    
    final Widget contentView = GetBuilder<T>(
      init: logic,
      builder: (controller) => PageStatusWidget(
        logic: controller,
        childBuilder: () => buildContent(context),
      ),
    );

    return isScaffold() ? buildScaffold(contentView) : contentView;
  }

  /// 初始化屏幕适配工具
  void _initScreenUtil(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenUtil = ScreenUtil();

    if (orientation == Orientation.portrait && !_isPortraitInitialized(screenUtil)) {
      ScreenUtil.init(context, designSize: portraitDesignSize);
    } else if (orientation == Orientation.landscape && !_isLandscapeInitialized(screenUtil)) {
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