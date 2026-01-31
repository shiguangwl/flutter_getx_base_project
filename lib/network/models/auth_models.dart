import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

/// 用户注册请求体
@JsonSerializable()
class AppRegisterBo {
  /// 用户名称
  @JsonKey(name: 'username')
  final String username;

  /// 密码
  @JsonKey(name: 'password')
  final String password;

  /// 邀请码
  @JsonKey(name: 'inviteCode')
  final String inviteCode;

  /// 角色枚举（前端无需理会）
  @JsonKey(name: 'roleEnum')
  final String? roleEnum;

  const AppRegisterBo({
    required this.username,
    required this.password,
    required this.inviteCode,
    this.roleEnum,
  });

  factory AppRegisterBo.fromJson(Map<String, dynamic> json) =>
      _$AppRegisterBoFromJson(json);

  Map<String, dynamic> toJson() => _$AppRegisterBoToJson(this);
}

/// 用户登录请求体
@JsonSerializable()
class AppLoginBo {
  /// 用户名
  @JsonKey(name: 'username')
  final String username;

  /// 用户密码
  @JsonKey(name: 'password')
  final String password;

  /// 设备ID
  @JsonKey(name: 'deviceId')
  final String? deviceId;

  const AppLoginBo({
    required this.username,
    required this.password,
    this.deviceId,
  });

  factory AppLoginBo.fromJson(Map<String, dynamic> json) =>
      _$AppLoginBoFromJson(json);

  Map<String, dynamic> toJson() => _$AppLoginBoToJson(this);
}

/// 登录响应数据
@JsonSerializable()
class AppLoginVo {
  /// 用户id
  @JsonKey(name: 'uid')
  final int uid;

  /// 访问令牌
  @JsonKey(name: 'accessToken')
  final String accessToken;

  /// 刷新令牌
  @JsonKey(name: 'refreshToken')
  final String? refreshToken;

  /// 过期时间
  @JsonKey(name: 'expireIn')
  final int expireIn;

  /// 登录时间
  @JsonKey(name: 'loginTime')
  final int loginTime;

  const AppLoginVo({
    required this.uid,
    required this.accessToken,
    required this.refreshToken,
    required this.expireIn,
    required this.loginTime,
  });

  factory AppLoginVo.fromJson(Map<String, dynamic> json) =>
      _$AppLoginVoFromJson(json);

  Map<String, dynamic> toJson() => _$AppLoginVoToJson(this);
}
