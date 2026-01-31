import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// 加密工具类
class CryptoUtil {
  CryptoUtil._();

  static String? _salt;
  static bool _initialized = false;

  /// 初始化加密工具
  static void init({required String salt}) {
    if (salt.length < 32) {
      throw ArgumentError('Salt must be at least 32 characters');
    }
    _salt = salt;
    _initialized = true;
  }

  static void _ensureInitialized() {
    if (!_initialized || _salt == null) {
      throw StateError('CryptoUtil not initialized. Call init() first.');
    }
  }

  /// 对密码进行哈希处理
  static String hashPassword(String password) {
    _ensureInitialized();
    final bytes = utf8.encode(password + _salt!);
    return sha256.convert(bytes).toString();
  }

  /// 验证密码是否正确
  static bool verifyPassword(String password, String hashedPassword) {
    return hashPassword(password) == hashedPassword;
  }

  /// 生成安全随机令牌
  static String generateToken(int length) {
    _ensureInitialized();
    final random = Random.secure();
    final values = List<int>.generate(32, (_) => random.nextInt(256));
    final bytes = utf8.encode(base64Encode(values) + _salt!);
    final digest = sha256.convert(bytes).toString();
    return digest.substring(0, length.clamp(1, 64));
  }
}
