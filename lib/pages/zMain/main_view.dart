import 'package:flutter/material.dart';

import '../../common/base/config/view_config.dart';
import '../../common/base/view/base_view.dart';
import '../../common/utils/event_bus.dart';
import '../../config/theme/app_colors.dart';
import '../../constant/global_event.dart';
import '../../widgets/common_style.dart';
import 'home/home_view.dart';
import 'main_logic.dart';
import 'my/my_view.dart';

class MainPage extends BaseView<MainPageLogic> {
  static String HomePageRoute = 'HomePage';
  static String MyPageRoute = 'MyPage';

  final Map<String, int> _pageMap = {
    HomePageRoute: 0,
    MyPageRoute: 1,
  };

  MainPage({super.key}) {
    bus.on(GlobalEvent.doSwitchPageEvent, (pageName) {
      logic.switchPage(_pageMap[pageName]!);
    });
  }

  @override
  ViewConfig get viewConfig => ViewConfig(useScaffold: false);

  final Map<Widget, BottomNavigationBarItem> pageList = {
    Container(
      decoration: CommonStyle.gradientBg,
      child: const HomePage(),
    ): const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: '首页',
    ),
    Container(
      decoration: CommonStyle.gradientBg,
      child: const MyPage(),
    ): const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: '我的',
    ),
  };

  @override
  Widget buildContent() {
    return Builder(builder: (context) {
      return Column(
        children: [
          Expanded(
            child: PageView(
              controller: logic.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: pageList.keys.toList(),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColors.of.surface,
              currentIndex: logic.currentIndex,
              onTap: logic.switchPage,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              enableFeedback: false,
              selectedItemColor: AppColors.of.primary,
              unselectedItemColor: AppColors.of.icon,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedIconTheme: const IconThemeData(size: 24),
              unselectedIconTheme: const IconThemeData(size: 24),
              items: pageList.values.toList(),
            ),
          ),
        ],
      );
    });
  }
}
