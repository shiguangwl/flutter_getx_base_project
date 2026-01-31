import 'package:get/get.dart';

import 'api_service/user_service.dart';
import 'locale_service.dart';
import 'persistent_service.dart';
import 'theme_service.dart';

/// 服务管理类
/// 统一管理所有服务的初始化和获取
class Ainit {
  Ainit._();

  /// 初始化所有服务
  static Future<void> init() async {
    await PersistentService.init();
    Get.put(ThemeService());
    Get.put(LocaleService());
    Get.put(UserService());
  }
}
