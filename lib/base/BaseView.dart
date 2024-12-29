import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/them_config.dart';

abstract class BaseView extends StatelessWidget {
  BaseView({super.key});

  /// 状态栏高度
  double statusBarH = ScreenUtil().statusBarHeight;

  /// 导航栏高度
  double navBarH = AppBar().preferredSize.height;

  /// 安全区域高度
  double safeBarH = ScreenUtil().bottomBarHeight;

  /// 设置主主视图内容(子类不实现会报错)
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenUtil = ScreenUtil();

    // 根据屏幕方向初始化设计尺寸
    if (orientation == Orientation.portrait &&
        (screenUtil.screenWidth != portraitDesignSize.width ||
            screenUtil.screenHeight != portraitDesignSize.height)) {
      ScreenUtil.init(context, designSize: portraitDesignSize);
    } else if (orientation == Orientation.landscape &&
        (screenUtil.screenWidth != landscapeDesignSize.width ||
            screenUtil.screenHeight != landscapeDesignSize.height)) {
      ScreenUtil.init(context, designSize: landscapeDesignSize);
    }
    return buildContent(context);
  }
}