import 'dart:io';

class HttpConfig {
  // DEV环境
  static String BASE_URL_DEV =
      Platform.isAndroid ? 'http://192.168.0.28:8080' : 'http://127.0.0.1:8080';

  // SIT环境
  static String BASE_URL_SIT = 'http://192.168.1.250:28080';

  // UAT环境
  static String BASE_URL_UAT = 'http://192.168.1.250:28087';

  // PROD环境
  static String BASE_URL_PROD = 'https://hy.l595.com/prod-api';
}
