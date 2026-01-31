import 'dart:convert';
import 'dart:math';

import 'package:hive_ce/hive.dart';

/// 加密助手
/// 管理 Hive 加密 Box 的密钥生成和获取
class EncryptionHelper {
  static const _encryptionKeyName = 'encryption_key';

  final Box<dynamic> _keyStore;

  EncryptionHelper(this._keyStore);

  /// 获取或创建 AES 加密密钥
  Future<List<int>> getOrCreateKey() async {
    final stored = _keyStore.get(_encryptionKeyName) as String?;
    if (stored != null) {
      return base64Decode(stored);
    }

    final key = List<int>.generate(32, (_) => Random.secure().nextInt(256));
    await _keyStore.put(_encryptionKeyName, base64Encode(key));
    return key;
  }
}
