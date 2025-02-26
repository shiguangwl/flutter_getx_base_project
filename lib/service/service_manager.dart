import 'package:get/get.dart';

import '../persistent/persistent_service.dart';
import 'AuthService.dart';
import 'user_service.dart';

/// 服务管理类
/// 统一管理所有服务的初始化和获取
class ServiceManager {
  /// 私有构造函数，防止实例化
  ServiceManager._();
  
  /// 初始化所有服务
  static Future<void> init() async {
    // 初始化持久化服务
    final persistentService = Get.put<PersistentService>(PersistentService());
    await persistentService.init();
    
    // 注册用户服务
    Get.put<UserService>(UserService());
    
    // 注册认证服务
    Get.put<AuthService>(AuthService());
  }
  
  /// 获取持久化服务
  static PersistentService get persistentService => Get.find<PersistentService>();
  
  /// 获取用户服务
  static UserService get userService => Get.find<UserService>();
  
  /// 获取认证服务
  static AuthService get authService => Get.find<AuthService>();
  
  /// 关闭所有服务
  static Future<void> close() async {
    // 关闭持久化服务
    await persistentService.close();
    
    // 删除所有服务实例
    Get.delete<AuthService>();
    Get.delete<UserService>();
    Get.delete<PersistentService>();
  }
} 