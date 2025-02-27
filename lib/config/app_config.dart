import 'package:lanyu_chat/persistent/sp_storage.dart';

/// 应用配置管理类
class AppConfig {
  // 配置项的key常量
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLanguage = 'language';
  static const String _keyToken = 'token';
  static const String _keyUserInfo = 'user_info';
  static const String _keyFirstLaunch = 'first_launch';
  
  /// 设置主题模式（0: 跟随系统, 1: 亮色模式, 2: 暗色模式）
  static Future<bool> setThemeMode(int mode) async {
    return await SPStorage.setInt(_keyThemeMode, mode);
  }
  
  /// 获取主题模式
  static int getThemeMode() {
    return SPStorage.getInt(_keyThemeMode, defaultValue: 0);
  }
  
  /// 设置语言
  static Future<bool> setLanguage(String language) async {
    return await SPStorage.setString(_keyLanguage, language);
  }
  
  /// 获取语言
  static String getLanguage() {
    return SPStorage.getString(_keyLanguage, defaultValue: 'zh_CN');
  }
  
  /// 设置token
  static Future<bool> setToken(String token) async {
    return await SPStorage.setString(_keyToken, token);
  }
  
  /// 获取token
  static String getToken() {
    return SPStorage.getString(_keyToken);
  }
  
  /// 设置用户信息
  static Future<bool> setUserInfo(Map<String, dynamic> userInfo) async {
    return await SPStorage.setMap(_keyUserInfo, userInfo);
  }
  
  /// 获取用户信息
  static Map<String, dynamic> getUserInfo() {
    return SPStorage.getMap(_keyUserInfo);
  }
  
  /// 设置是否首次启动
  static Future<bool> setFirstLaunch(bool isFirst) async {
    return await SPStorage.setBool(_keyFirstLaunch, isFirst);
  }
  
  /// 获取是否首次启动
  static bool isFirstLaunch() {
    return SPStorage.getBool(_keyFirstLaunch, defaultValue: true);
  }
  
  /// 清除用户相关数据（退出登录时调用）
  static Future<void> clearUserData() async {
    await SPStorage.remove(_keyToken);
    await SPStorage.remove(_keyUserInfo);
  }
} 