import 'package:flutter_getx_base_project/persistent/hive/base/hive_base_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_getx_base_project/persistent/hive/model/User.dart';

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();
  factory HiveManager() => _instance;
  HiveManager._internal();

  final Map<String, dynamic> _services = {};
  bool _initialized = false;

  /// 初始化Hive
  Future<void> initHive() async {
    if (_initialized) return;
    
    await Hive.initFlutter();
    // 注册适配器
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    
    _initialized = true;
  }

  /// 注册服务
  T registerService<T>(T service) {
    if (service is HiveBaseService) {
      if (!_services.containsKey(service.boxName)) {
        _services[service.boxName] = service;
        // 自动初始化service
        service.init();
      }
      return _services[service.boxName] as T;
    }
    return service;
  }

  /// 获取服务
  T? getService<T>(String boxName) {
    return _services[boxName] as T?;
  }

  /// 应用退出时关闭所有服务
  Future<void> dispose() async {
    for (var service in _services.values) {
      if (service is HiveBaseService) {
        await service.close();
      }
    }
    _services.clear();
    _initialized = false;
  }
} 