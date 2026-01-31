/// 环境类型枚举
enum EnvType {
  dev,
  test,
  prod;

  static EnvType fromString(String value) {
    return EnvType.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => EnvType.prod,
    );
  }

  bool get isDev => this == EnvType.dev;
  bool get isTest => this == EnvType.test;
  bool get isProd => this == EnvType.prod;
  bool get isDebugMode => isDev || isTest;
}
