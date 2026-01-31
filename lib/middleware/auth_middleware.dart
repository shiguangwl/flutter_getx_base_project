import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:liushui_app/service/api_service/user_service.dart';
import '../routes/router.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    try {
      // 获取存储的认证信息
      final tokenExists = UserService.to.hasToken;

      // 如果未登录，重定向到登录页面
      if (!tokenExists) {
        return RouteSettings(name: AppRoutes.Login);
      }
    } catch (e) {
      // 如果服务未初始化，重定向到登录页面
      return RouteSettings(name: AppRoutes.Login);
    }

    return null;
  }
}
