import '../../../i18n/i18_text.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    Map<String, Map<String, String>> translations = {};

    translations.addAll(EnUs().keys);
    translations.addAll(ZhCn().keys);

    return translations;
  }
}

class EnUs extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {Language.enUs: getI18Map(Language.enUs)};
}

class ZhCn extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {Language.zhCn: getI18Map(Language.zhCn)};
}
