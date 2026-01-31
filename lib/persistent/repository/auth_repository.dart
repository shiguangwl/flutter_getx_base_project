import 'package:hive_ce/hive.dart';

/// 认证仓库
/// 管理 Token 和登录状态（加密存储）
class AuthRepository {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final Box<dynamic> _secureBox;

  AuthRepository(this._secureBox);

  String? getAccessToken() {
    final token = _secureBox.get(_accessTokenKey) as String?;
    return (token?.isEmpty ?? true) ? null : token;
  }

  Future<void> saveAccessToken(String token) =>
      _secureBox.put(_accessTokenKey, token);

  String? getRefreshToken() {
    final token = _secureBox.get(_refreshTokenKey) as String?;
    return (token?.isEmpty ?? true) ? null : token;
  }

  Future<void> saveRefreshToken(String token) =>
      _secureBox.put(_refreshTokenKey, token);

  bool hasToken() {
    final token = _secureBox.get(_accessTokenKey) as String?;
    return token?.isNotEmpty ?? false;
  }

  Future<void> clearTokens() async {
    await _secureBox.delete(_accessTokenKey);
    await _secureBox.delete(_refreshTokenKey);
  }
}
