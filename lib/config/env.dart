
import '../utils/log_util.dart';
import 'ev_config.dart';
import 'http_config.dart';

class Env {
  /// 当前环境
  static String currEnv = EnvConfig.dev;

  // static String currEnv = EnvConfig.prod;

  /// 获取对应环境的配置
  /// [env] 可选|指定环境
  static EnvConfig getEnvConfig({String env = EnvConfig.dev}) {
    EnvConfig envConfig;
    switch (env) {
      case EnvConfig.sit:
        envConfig = _sitConfig;
        break;
      case EnvConfig.uat:
        envConfig = _uatConfig;
        break;
      case EnvConfig.prod:
        envConfig = _prodConfig;
        break;
      default:
        envConfig = _devConfig;
    }
    logD('当前环境: $envConfig');
    return envConfig;
  }

  /// 开发环境配置项
  static final EnvConfig _devConfig = EnvConfig(
    baseUrl: HttpConfig.BASE_URL_DEV,
  );

  /// 测试环境配置项
  static final EnvConfig _sitConfig = EnvConfig(
    baseUrl: HttpConfig.BASE_URL_SIT,
  );

  /// 预生产环境配置项
  static final EnvConfig _uatConfig = EnvConfig(
    baseUrl: HttpConfig.BASE_URL_UAT,
  );

  /// 生产环境配置项
  static final EnvConfig _prodConfig = EnvConfig(
    baseUrl: HttpConfig.BASE_URL_PROD,
    isDebug: false,
  );

  ///获取当前域名
  static String getCurrentBaseUrl() {
    return getEnvConfig(env: currEnv).baseUrl;
  }

  ///是否不是正式环境
  static bool isNotProductionEnv() {
    return getCurrentBaseUrl() != HttpConfig.BASE_URL_PROD;
  }
}
