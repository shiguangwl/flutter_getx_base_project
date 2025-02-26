import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences存储封装
/// 用于存储应用配置数据和简单的键值对数据
class SPStorage {
  static late SharedPreferences _prefs;
  
  /// 初始化SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  /// 存储String类型数据
  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }
  
  /// 获取String类型数据
  static String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }
  
  /// 存储int类型数据
  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }
  
  /// 获取int类型数据
  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }
  
  /// 存储double类型数据
  static Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }
  
  /// 获取double类型数据
  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }
  
  /// 存储bool类型数据
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }
  
  /// 获取bool类型数据
  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }
  
  /// 存储List<String>类型数据
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }
  
  /// 获取List<String>类型数据
  static List<String> getStringList(String key, {List<String> defaultValue = const []}) {
    return _prefs.getStringList(key) ?? defaultValue;
  }
  
  /// 存储Map类型数据（转换为JSON字符串）
  static Future<bool> setMap(String key, Map<String, dynamic> value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }
  
  /// 获取Map类型数据（从JSON字符串转换）
  static Map<String, dynamic> getMap(String key, {Map<String, dynamic> defaultValue = const {}}) {
    String jsonStr = _prefs.getString(key) ?? '';
    if (jsonStr.isEmpty) {
      return defaultValue;
    }
    try {
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (e) {
      return defaultValue;
    }
  }
  
  /// 存储对象（需要对象实现toJson方法）
  static Future<bool> setObject(String key, dynamic object) async {
    if (object == null) return false;
    return await _prefs.setString(key, jsonEncode(object));
  }
  
  /// 获取对象（需要提供fromJson构造函数）
  static T? getObject<T>(String key, T Function(Map<String, dynamic> json) fromJson) {
    String jsonStr = _prefs.getString(key) ?? '';
    if (jsonStr.isEmpty) {
      return null;
    }
    try {
      return fromJson(jsonDecode(jsonStr) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
  
  /// 检查是否包含某个key
  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
  
  /// 删除某个key对应的数据
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
  
  /// 清除所有数据
  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
