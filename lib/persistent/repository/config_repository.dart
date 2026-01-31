import 'package:hive_ce/hive.dart';

/// 配置仓库
/// 管理应用配置：主题、语言、首次启动等
class ConfigRepository {
  static const _themeModeKey = 'theme_mode';
  static const _followSystemKey = 'follow_system_theme';
  static const _languageCodeKey = 'language_code';
  static const _countryCodeKey = 'country_code';
  static const _firstLaunchKey = 'first_launch';
  static const _agreeTermsKey = 'agree_terms';

  final Box<dynamic> _box;

  ConfigRepository(this._box);

  int getThemeMode() => _box.get(_themeModeKey, defaultValue: 0) as int;

  Future<void> setThemeMode(int mode) => _box.put(_themeModeKey, mode);

  bool getFollowSystemTheme() =>
      _box.get(_followSystemKey, defaultValue: false) as bool;

  Future<void> setFollowSystemTheme(bool value) =>
      _box.put(_followSystemKey, value);

  String? getLanguageCode() => _box.get(_languageCodeKey) as String?;

  String? getCountryCode() => _box.get(_countryCodeKey) as String?;

  Future<void> setLanguage(String languageCode, String? countryCode) async {
    await _box.put(_languageCodeKey, languageCode);
    if (countryCode != null) {
      await _box.put(_countryCodeKey, countryCode);
    } else {
      await _box.delete(_countryCodeKey);
    }
  }

  Future<void> clearLanguage() async {
    await _box.delete(_languageCodeKey);
    await _box.delete(_countryCodeKey);
  }

  bool isFirstLaunch() => _box.get(_firstLaunchKey, defaultValue: true) as bool;

  Future<void> setFirstLaunch(bool value) => _box.put(_firstLaunchKey, value);

  bool getAgreeTerms() => _box.get(_agreeTermsKey, defaultValue: false) as bool;

  Future<void> setAgreeTerms(bool value) => _box.put(_agreeTermsKey, value);
}
