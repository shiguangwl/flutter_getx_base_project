import 'package:get/get.dart';

import '../pages/launch/view.dart';


class AppRoutes {
  // 启动页
  static String Launch = '/launch';


  static List<GetPage> routes = [
    GetPage(name: Launch, page: () => LaunchPage()),
  ];
}
