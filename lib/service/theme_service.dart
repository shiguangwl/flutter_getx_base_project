import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../config/theme/app_theme.dart';
import '../config/theme/theme_data_factory.dart';
import 'persistent_service.dart';

/// 主题服务 - 基于 GetX 的多主题切换
class ThemeService extends GetxService {
  static ThemeService get to => Get.find<ThemeService>();

  final Rx<AppTheme> _currentTheme = AppTheme.light.obs;
  final RxBool _followSystem = false.obs;

  AppTheme get currentTheme => _currentTheme.value;
  bool get followSystem => _followSystem.value;
  bool get isDarkMode => _currentTheme.value.isDark;

  /// 所有可用主题列表
  List<AppTheme> get availableThemes => AppTheme.values;

  @override
  void onInit() {
    super.onInit();
    _loadSavedTheme();
    _listenSystemBrightness();
  }

  void _loadSavedTheme() {
    final savedIndex = PersistentService.to.config.getThemeMode();
    final followSys = PersistentService.to.config.getFollowSystemTheme();

    _followSystem.value = followSys;

    if (followSys) {
      _applySystemTheme();
    } else if (savedIndex >= 0 && savedIndex < AppTheme.values.length) {
      _currentTheme.value = AppTheme.values[savedIndex];
    }
  }

  void _listenSystemBrightness() {
    final dispatcher = SchedulerBinding.instance.platformDispatcher;
    dispatcher.onPlatformBrightnessChanged = () {
      if (_followSystem.value) {
        _applySystemTheme();
        _updateGetXTheme();
      }
    };
  }

  void _applySystemTheme() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    _currentTheme.value =
        brightness == Brightness.dark ? AppTheme.dark : AppTheme.light;
  }

  void _updateGetXTheme() {
    final themeData = ThemeDataFactory.getThemeData(_currentTheme.value);
    Get.changeTheme(themeData);
  }

  /// 切换到指定主题
  Future<void> setTheme(AppTheme theme) async {
    _followSystem.value = false;
    _currentTheme.value = theme;
    await _savePreferences();
    _updateGetXTheme();
  }

  /// 设置是否跟随系统
  Future<void> setFollowSystem(bool follow) async {
    _followSystem.value = follow;
    if (follow) {
      _applySystemTheme();
    }
    await _savePreferences();
    _updateGetXTheme();
  }

  /// 切换亮/暗模式（在当前主题基础上）
  Future<void> toggleDarkMode() async {
    final newTheme = isDarkMode ? AppTheme.light : AppTheme.dark;
    await setTheme(newTheme);
  }

  /// 循环切换所有主题
  Future<void> cycleTheme() async {
    final currentIndex = AppTheme.values.indexOf(_currentTheme.value);
    final nextIndex = (currentIndex + 1) % AppTheme.values.length;
    await setTheme(AppTheme.values[nextIndex]);
  }

  Future<void> _savePreferences() async {
    await PersistentService.to.config.setThemeMode(_currentTheme.value.index);
    await PersistentService.to.config.setFollowSystemTheme(_followSystem.value);
  }

  /// 获取当前主题的 ThemeData
  ThemeData get themeData => ThemeDataFactory.getThemeData(_currentTheme.value);

  /// 获取当前主题名称
  String get themeName => _currentTheme.value.label;

  /// 获取主题图标
  IconData get themeIcon {
    if (_followSystem.value) return Icons.settings_brightness;
    return isDarkMode ? Icons.dark_mode : Icons.light_mode;
  }
}
