import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'persistent_service.dart';

class LocaleService extends GetxService {
  static LocaleService get to => Get.find();

  final List<Locale> supportedLocales = [
    const Locale('zh', 'CN'),
    const Locale('en', 'US'),
  ];

  final Rx<Locale?> _locale = Rx<Locale?>(null);
  Locale? get locale => _locale.value;

  PersistentService get _persistent => PersistentService.to;

  @override
  void onReady() {
    super.onReady();
    _loadSavedLocale();
  }

  void _loadSavedLocale() {
    final String? languageCode = _persistent.config.getLanguageCode();
    final String? countryCode = _persistent.config.getCountryCode();

    if (languageCode != null) {
      _locale.value = Locale(languageCode, countryCode);
      Get.updateLocale(_locale.value!);
    } else {
      _useDeviceLocale();
    }
  }

  void _useDeviceLocale() {
    final deviceLocale = Get.deviceLocale;
    if (deviceLocale != null && _isSupported(deviceLocale)) {
      _locale.value = deviceLocale;
    } else {
      _locale.value = const Locale('zh', 'CN');
    }
    Get.updateLocale(_locale.value!);
  }

  bool _isSupported(Locale locale) {
    return supportedLocales.any((sl) => sl.languageCode == locale.languageCode);
  }

  Future<void> changeLocale(String languageCode, String? countryCode) async {
    final newLocale = Locale(languageCode, countryCode);
    _locale.value = newLocale;
    Get.updateLocale(newLocale);
    await _persistent.config.setLanguage(languageCode, countryCode);
  }

  Future<void> useSystemLocale() async {
    await _persistent.config.clearLanguage();
    _useDeviceLocale();
  }
}
