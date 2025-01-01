import 'package:flutter/widgets.dart';
import 'package:flutter_getx_base_project/service/AuthService.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {

    // 获取存储的认证信息
    final authService = Get.find<AuthService>();
    
    // 如果未登录，重定向到登录页面
    if (!authService.isLoggedIn) {
      return const RouteSettings(name: '/login');
    }
    
    return null;
  }
}