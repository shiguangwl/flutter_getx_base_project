import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/event_bus.dart';
import '../config/view_config.dart';

abstract class AbstractBaseController extends GetxController {
  /// 当前控制器注册的事件
  final _emap = <Object, List<EventCallback>?>{};

  void registerEventListener(Object eventName, EventCallback listener) {
    bus.on(eventName, listener);
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(listener);
  }

  void removeEventListener(Object eventName, EventCallback listener) {
    bus.off(eventName, listener);
  }

  void emitEvent(Object eventName, [dynamic arg]) {
    bus.emit(eventName, arg);
  }

  @override
  void onClose() {
    for (var eventName in _emap.keys) {
      removeEventListener(eventName, _emap[eventName]![0]);
    }
    super.onClose();
  }
}

abstract class AbstractBaseView<T extends AbstractBaseController>
    extends GetView<T> {
  const AbstractBaseView({super.key});

  /// 视图配置
  ViewConfig get viewConfig => ViewConfig();

  /// 状态栏高度
  double get statusBarH => MediaQuery.of(Get.context!).padding.top;

  /// 导航栏高度
  double get navBarH => kToolbarHeight;

  /// 安全区域底部高度
  double get safeBarH => MediaQuery.of(Get.context!).padding.bottom;

  /// 屏幕宽度
  double get screenWidth => MediaQuery.of(Get.context!).size.width;

  /// 屏幕高度
  double get screenHeight => MediaQuery.of(Get.context!).size.height;

  /// 是否构建Scaffold
  bool get isScaffold => viewConfig.useScaffold;

  /// 是否添加左右边距
  bool get isAddPadding => viewConfig.addHorizontalPadding;

  /// 控制器实例的便捷访问
  T get logic => controller;

  /// 构建主视图内容
  /// 子类必须实现此方法以提供具体的UI内容
  Widget buildContent();

  /// 构建Scaffold
  /// 如果需要自定义Scaffold请重写当前方法
  /// @param contentView 构建的内容视图
  /// @return 自定义的Scaffold
  Widget buildScaffold(Widget contentView) {
    return Scaffold(
      appBar: buildAppBar(),
      body: contentView,
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  /// 构建AppBar
  PreferredSizeWidget? buildAppBar() => null;

  /// 构建悬浮按钮
  Widget? buildFloatingActionButton() => null;

  /// 构建底部导航栏
  Widget? buildBottomNavigationBar() => null;

  @override
  Widget build(BuildContext context) {
    Widget contentView = buildContent();
    if (isAddPadding) {
      contentView = Padding(
        padding: EdgeInsets.symmetric(horizontal: viewConfig.horizontalPadding),
        child: contentView,
      );
    }

    contentView = buildContentWrapper(contentView);
    return isScaffold ? buildScaffold(contentView) : contentView;
  }

  /// 构建内容包装器
  Widget buildContentWrapper(Widget contentView) {
    return contentView;
  }
}
