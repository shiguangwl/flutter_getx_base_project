import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../pages/launch/binding.dart';
import '../pages/launch/view.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_view.dart';
import '../pages/zMain/main_binding.dart';
import '../pages/zMain/main_view.dart';
// Demo imports
import '../pages/demo/base/base_view_demo/base_view_demo_binding.dart';
import '../pages/demo/base/base_view_demo/base_view_demo_view.dart';
import '../pages/demo/base/refreshable_demo/refreshable_demo_binding.dart';
import '../pages/demo/base/refreshable_demo/refreshable_demo_view.dart';
import '../pages/demo/base/page_status_demo/page_status_demo_binding.dart';
import '../pages/demo/base/page_status_demo/page_status_demo_view.dart';
import '../pages/demo/network/network_demo_binding.dart';
import '../pages/demo/network/network_demo_view.dart';
import '../pages/demo/persistent/hive_demo/hive_demo_binding.dart';
import '../pages/demo/persistent/hive_demo/hive_demo_view.dart';
import '../pages/demo/routing/routing_demo_binding.dart';
import '../pages/demo/routing/routing_demo_view.dart';
import '../pages/demo/routing/route_target_view.dart';

class AppRoutes {
  static const String Launch = '/launch';
  static const String Login = '/login';
  static const String Home = '/home';

  // Demo routes
  static const String demoBaseView = '/demo/base-view';
  static const String demoRefreshable = '/demo/refreshable';
  static const String demoPageStatus = '/demo/page-status';
  static const String demoNetwork = '/demo/network';
  static const String demoHive = '/demo/hive';
  static const String demoGetxReactive = '/demo/getx-reactive';
  static const String demoDependency = '/demo/dependency';
  static const String demoEventBus = '/demo/event-bus';
  static const String demoRouting = '/demo/routing';
  static const String demoRouteTarget = '/demo/route-target';

  // 公开路由配置
  static final List<dynamic> publicRoutes = [
    Launch,
    Login,
    // Demo routes are public for testing
    RegExp(r'^/demo/.*'),
  ];

  static List<GetPage> routes = [
    GetPage(
      name: Launch,
      page: () => LaunchPage(),
      binding: LaunchPageBinding(),
    ),
    GetPage(
      name: Home,
      page: () => MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: Login,
      page: () => LoginPage(),
      binding: LoginPageBinding(),
    ),
    // Demo pages
    GetPage(
      name: demoBaseView,
      page: () => const BaseViewDemoPage(),
      binding: BaseViewDemoBinding(),
    ),
    GetPage(
      name: demoRefreshable,
      page: () => const RefreshableDemoPage(),
      binding: RefreshableDemoBinding(),
    ),
    GetPage(
      name: demoPageStatus,
      page: () => const PageStatusDemoPage(),
      binding: PageStatusDemoBinding(),
    ),
    GetPage(
      name: demoNetwork,
      page: () => const NetworkDemoPage(),
      binding: NetworkDemoBinding(),
    ),
    GetPage(
      name: demoHive,
      page: () => const HiveDemoPage(),
      binding: HiveDemoBinding(),
    ),
    GetPage(
      name: demoRouting,
      page: () => const RoutingDemoPage(),
      binding: RoutingDemoBinding(),
    ),
    GetPage(
      name: demoRouteTarget,
      page: () => const RouteTargetPage(),
    ),
  ].map(_decorateWithAuth).toList();

  static GetPage _decorateWithAuth(GetPage page) {
    if (_isPublicRoute(page.name)) {
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

  static bool _isPublicRoute(String routeName) {
    for (var route in publicRoutes) {
      if (route is String && route == routeName) {
        return true;
      } else if (route is RegExp && route.hasMatch(routeName)) {
        return true;
      }
    }
    return false;
  }
}
