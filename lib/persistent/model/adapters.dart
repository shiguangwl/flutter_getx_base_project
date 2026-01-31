import 'package:hive_ce/hive.dart';

import 'user_model.dart';

/// 注册所有适配器
void registerAllAdapters() {
  Hive.registerAdapter(UserModelAdapter());
}

/// Box 定义
class BoxDef<T> {
  final String name;
  final bool encrypted;

  const BoxDef(this.name, {this.encrypted = false});

  /// 打开 box（保持正确的泛型类型）
  Future<Box<T>> open([HiveCipher? cipher]) async {
    return Hive.openBox<T>(name, encryptionCipher: cipher);
  }
}

/// 所有 Box 集中定义
abstract final class Boxes {
  static const config = BoxDef<dynamic>('config_box');
  static const secure = BoxDef<dynamic>('secure_box', encrypted: true);
  static const user = BoxDef<UserModel>('user_box');
  static const demo = BoxDef<String>('demo_box');

  static List<BoxDef<dynamic>> get all => [config, secure, user];
}
