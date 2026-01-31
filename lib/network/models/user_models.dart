import 'package:json_annotation/json_annotation.dart';

part 'user_models.g.dart';

/// 用户信息视图对象
@JsonSerializable()
class MbUserVo {
  /// 创建时间
  @JsonKey(name: 'createTime')
  final int? createTime;

  /// 昵称
  @JsonKey(name: 'nickname')
  final String? nickname;

  /// 用户名称
  @JsonKey(name: 'username')
  final String? username;

  /// 用户ID
  @JsonKey(name: 'id')
  final int id;

  /// 用户号
  @JsonKey(name: 'userNo')
  final int userNo;

  /// 头像
  @JsonKey(name: 'avatar')
  final String? avatar;

  /// 手机号
  @JsonKey(name: 'phone')
  final String? phone;

  /// 邮箱
  @JsonKey(name: 'email')
  final String? email;

  /// 登陆密码
  @JsonKey(name: 'password')
  final String? password;

  /// 取款密码
  @JsonKey(name: 'withdrawPassword')
  final String? withdrawPassword;

  /// 上级用户ID
  @JsonKey(name: 'pid')
  final int? pid;

  /// 邀请码
  @JsonKey(name: 'invitationCode')
  final String invitationCode;

  /// 角色(member会员 test 测试用户 demo 试玩用户)
  @JsonKey(name: 'role')
  final String? role;

  /// 冻结账号状态(0无冻结 1已冻结)
  @JsonKey(name: 'accountFreeze')
  final int accountFreeze;

  /// 最后登录时间
  @JsonKey(name: 'lastLoginTime')
  final int? lastLoginTime;

  /// 标识
  @JsonKey(name: 'imei')
  final String? imei;

  const MbUserVo({
    this.createTime,
    this.nickname,
    this.username,
    required this.id,
    required this.userNo,
    this.avatar,
    this.phone,
    this.email,
    this.password,
    this.withdrawPassword,
    this.pid,
    required this.invitationCode,
    this.role,
    required this.accountFreeze,
    this.lastLoginTime,
    this.imei,
  });

  factory MbUserVo.fromJson(Map<String, dynamic> json) =>
      _$MbUserVoFromJson(json);

  Map<String, dynamic> toJson() => _$MbUserVoToJson(this);
}

/// 修改密码请求体
@JsonSerializable()
class AppPasswordBo {
  /// 旧密码
  @JsonKey(name: 'oldPassword')
  final String oldPassword;

  /// 新密码
  @JsonKey(name: 'newPassword')
  final String newPassword;

  /// 验证码
  @JsonKey(name: 'verificationCode')
  final String? verificationCode;

  const AppPasswordBo({
    required this.oldPassword,
    required this.newPassword,
    this.verificationCode,
  });

  factory AppPasswordBo.fromJson(Map<String, dynamic> json) =>
      _$AppPasswordBoFromJson(json);

  Map<String, dynamic> toJson() => _$AppPasswordBoToJson(this);
}

/// 更新用户信息请求体
@JsonSerializable()
class AppUserUpdateBo {
  /// 手机号
  @JsonKey(name: 'phone')
  final String? phone;

  /// 昵称
  @JsonKey(name: 'nickname')
  final String? nickname;

  /// 头像
  @JsonKey(name: 'avatar')
  final String? avatar;

  /// 冻结账号 true冻结，其他不修改
  @JsonKey(name: 'accountFreeze')
  final bool? accountFreeze;

  /// 刷脸/指纹字符串
  @JsonKey(name: 'faceFinger')
  final String? faceFinger;

  const AppUserUpdateBo({
    this.phone,
    this.nickname,
    this.avatar,
    this.accountFreeze,
    this.faceFinger,
  });

  factory AppUserUpdateBo.fromJson(Map<String, dynamic> json) =>
      _$AppUserUpdateBoFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserUpdateBoToJson(this);
}

/// 发送邮箱验证码请求体
@JsonSerializable()
class EmailSendDto {
  /// 邮箱
  @JsonKey(name: 'email')
  final String email;

  const EmailSendDto({
    required this.email,
  });

  factory EmailSendDto.fromJson(Map<String, dynamic> json) =>
      _$EmailSendDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EmailSendDtoToJson(this);
}

/// 绑定邮箱请求体
@JsonSerializable()
class EmailBindDto {
  /// 邮箱
  @JsonKey(name: 'email')
  final String email;

  /// 验证码
  @JsonKey(name: 'code')
  final String code;

  const EmailBindDto({
    required this.email,
    required this.code,
  });

  factory EmailBindDto.fromJson(Map<String, dynamic> json) =>
      _$EmailBindDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EmailBindDtoToJson(this);
}
