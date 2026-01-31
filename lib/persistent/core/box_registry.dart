import 'package:hive_ce_flutter/hive_flutter.dart';

import '../model/adapters.dart';
import 'encryption_helper.dart';

/// Box 注册中心
/// 统一管理所有 Hive Box 的创建和获取
class BoxRegistry {
  Box<dynamic>? _configBox;
  Box<dynamic>? _secureBox;
  List<int>? _encryptionKey;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Box<dynamic> get configBox {
    _ensureInitialized();
    return _configBox!;
  }

  Box<dynamic> get secureBox {
    _ensureInitialized();
    return _secureBox!;
  }

  Box<T> getBox<T>(String name) {
    _ensureInitialized();
    return Hive.box<T>(name);
  }

  /// 初始化所有 Box
  Future<void> init() async {
    if (_isInitialized) return;

    await Hive.initFlutter();
    registerAllAdapters();

    _configBox = await Boxes.config.open();
    _secureBox = await _openEncryptedBox(Boxes.secure);
    await Boxes.user.open();

    _isInitialized = true;
  }

  Future<Box<dynamic>> _openEncryptedBox(BoxDef<dynamic> def) async {
    final helper = EncryptionHelper(_configBox!);
    _encryptionKey ??= await helper.getOrCreateKey();
    return def.open(HiveAesCipher(_encryptionKey!));
  }

  Future<void> close() async {
    await Hive.close();
    _configBox = null;
    _secureBox = null;
    _encryptionKey = null;
    _isInitialized = false;
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError('BoxRegistry 未初始化');
    }
  }
}
