import 'package:flutter_getx_base_project/persistent/hive/UserHiveService.dart';
import 'package:flutter_getx_base_project/persistent/hive/base/hive_manager.dart';

class PersistentInit {
  static Future<void> init() async {
    // 初始化Hive
    await HiveManager().initHive();
    
    // 预初始化常用服务
    UserHiveService.instance;
  }
}