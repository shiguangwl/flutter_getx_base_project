import 'package:lanyu_chat/middleware/AuthMiddleware.dart';
import 'package:lanyu_chat/pages/home/view.dart';
import 'package:get/get.dart';

import '../pages/launch/view.dart';
import '../pages/launch/logic.dart';
import '../pages/home/logic.dart';


class AppRoutes {

  // 不需要认证的路由列表
  static final List<String> publicRoutes = [
    '/launch',
    '/home',
    '/login',
    '/register',
    '/forgot-password',
    '/about',
  ];

  // 启动页
  static String Launch = '/launch';
  static String Home = '/home';

  static List<GetPage> routes = [
    GetPage(
      name: Launch, 
      page: () => LaunchPage(),
      binding: BindingsBuilder(() {
        Get.put(LaunchLogic());
      }),
    ),
    GetPage(
      name: Home, 
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.put(HomeLogic());
      }),
    ),
  ].map(_decorateWithAuth).toList();


  static GetPage _decorateWithAuth(GetPage page) {
    if (publicRoutes.contains(page.name)) {
      return page;
    }
    
    final middlewares = [...?page.middlewares, AuthMiddleware()];
    
    return GetPage(
      name: page.name,
      page: page.page,
      binding: page.binding,
      bindings: page.bindings,
      transition: page.transition,
      middlewares: middlewares,
    );
  }

}
