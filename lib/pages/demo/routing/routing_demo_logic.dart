import 'package:get/get.dart';
import '../../../routes/router.dart';

/// 路由演示控制器
class RoutingDemoLogic extends GetxController {
  final logs = <String>[].obs;

  void _log(String message) {
    final time = DateTime.now().toString().substring(11, 19);
    logs.insert(0, '[$time] $message');
    if (logs.length > 15) logs.removeLast();
  }

  void clearLogs() => logs.clear();

  /// 基础导航 - Get.toNamed
  void navigateToTarget() {
    _log('Get.toNamed() 跳转到目标页');
    Get.toNamed(AppRoutes.demoRouteTarget);
  }

  /// 带参数导航
  void navigateWithArguments() {
    final args = {
      'name': 'Flutter',
      'version': '3.0',
      'time': DateTime.now().toString()
    };
    _log('携带参数: $args');
    Get.toNamed(AppRoutes.demoRouteTarget, arguments: args);
  }

  /// URL 参数导航
  void navigateWithQueryParams() {
    _log('使用 URL 参数导航');
    Get.toNamed('${AppRoutes.demoRouteTarget}?id=123&type=demo');
  }

  /// 导航并替换当前页面
  void navigateAndReplace() {
    _log('Get.offNamed() 替换当前页');
    Get.offNamed(AppRoutes.demoRouteTarget, arguments: {'mode': 'replace'});
  }

  /// 导航并清空栈
  void navigateAndClearStack() {
    _log('Get.offAllNamed() 清空路由栈');
    Get.offAllNamed(AppRoutes.demoRouteTarget, arguments: {'mode': 'clearAll'});
  }

  /// 带返回结果的导航
  Future<void> navigateForResult() async {
    _log('等待返回结果...');
    final result = await Get.toNamed(AppRoutes.demoRouteTarget,
        arguments: {'waitResult': true});
    if (result != null) {
      _log('收到返回结果: $result');
    } else {
      _log('未收到返回结果（用户直接返回）');
    }
  }

  /// 返回上一页
  void goBack() {
    _log('Get.back() 返回');
    Get.back();
  }

  /// 返回到指定页面
  void backUntil() {
    _log('Get.until() 返回到首页');
    Get.until((route) => route.settings.name == AppRoutes.Home);
  }

  /// 获取当前路由信息
  void getCurrentRoute() {
    final currentRoute = Get.currentRoute;
    final previousRoute = Get.previousRoute;
    final routeArgs = Get.arguments;

    _log('当前路由: $currentRoute');
    _log('上一个路由: $previousRoute');
    _log('路由参数: $routeArgs');
  }

  /// 检查路由是否存在
  void checkRouteExists() {
    final routes = [AppRoutes.Home, AppRoutes.demoRouteTarget, '/not-exist'];
    for (final route in routes) {
      final exists = route.startsWith('/demo') || route == AppRoutes.Home;
      _log('$route: ${exists ? "✅" : "❌"}');
    }
  }
}
