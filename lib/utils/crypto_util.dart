import 'dart:convert';
import 'package:crypto/crypto.dart';

/// 加密工具类
/// 用于密码加密和验证
class CryptoUtil {
  /// 私有构造函数，防止实例化
  CryptoUtil._();
  
  /// 盐值，用于增强密码安全性
  static const String _salt = 'flutter_getx_base_project_salt';
  
  /// 对密码进行哈希处理
  /// 
  /// [password] 原始密码
  /// 
  /// 返回哈希后的密码
  static String hashPassword(String password) {
    final bytes = utf8.encode(password + _salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// 验证密码是否正确
  /// 
  /// [password] 原始密码
  /// [hashedPassword] 哈希后的密码
  /// 
  /// 返回密码是否正确
  static bool verifyPassword(String password, String hashedPassword) {
    final hashedInput = hashPassword(password);
    return hashedInput == hashedPassword;
  }
  
  /// 生成随机令牌
  /// 
  /// [length] 令牌长度
  /// 
  /// 返回随机令牌
  static String generateToken(int length) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final random = DateTime.now().microsecondsSinceEpoch.toString();
    final bytes = utf8.encode(timestamp + random + _salt);
    final digest = sha256.convert(bytes);
    return digest.toString().substring(0, length);
  }
} 