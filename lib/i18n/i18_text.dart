import '../../../i18n/i18_message.dart';

class Language {
  static const String zhCn = 'zh_CN';
  static const String enUs = 'en_US';
}

class MessageItem {
  final String zhValue;
  final String enValue;

  const MessageItem({required this.zhValue, required this.enValue});
}

Map<String, String> getI18Map(String language) {
  Map<String, String> map = {};
  I18TextMap.forEach((key, value) {
    if (language == Language.enUs) {
      map[key] = value.enValue;
    } else {
      map[key] = value.zhValue;
    }
  });
  return map;
}

// ignore: constant_identifier_names
const I18TextMap = {
  I18Message.loading: MessageItem(zhValue: '加载中', enValue: 'Loading...'),
  I18Message.success: MessageItem(zhValue: '成功', enValue: 'Success'),
  I18Message.error: MessageItem(zhValue: '失败', enValue: 'Error'),
};
