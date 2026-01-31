import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/base/controller/base_controller.dart';
import '../../common/base/state/page_constant.dart';
import '../../common/utils/event_bus.dart';
import '../../constant/global_event.dart';

class MainPageLogic extends BaseController {
  static MainPageLogic get to => Get.find<MainPageLogic>();

  // 当前页面索引
  final _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;

  // 页面控制器
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex);
  }

  // 切换页面
  void switchPage(int index) {
    bus.emit(GlobalEvent.switchPageEvent, index);

    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  Future<PageResult> onLoadPage() async {
    return const PageSuccess();
  }
}
