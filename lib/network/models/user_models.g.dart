// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MbUserVo _$MbUserVoFromJson(Map<String, dynamic> json) => MbUserVo(
      createTime: (json['createTime'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      username: json['username'] as String?,
      id: (json['id'] as num).toInt(),
      userNo: (json['userNo'] as num).toInt(),
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      withdrawPassword: json['withdrawPassword'] as String?,
      pid: (json['pid'] as num?)?.toInt(),
      invitationCode: json['invitationCode'] as String,
      role: json['role'] as String?,
      accountFreeze: (json['accountFreeze'] as num).toInt(),
      lastLoginTime: (json['lastLoginTime'] as num?)?.toInt(),
      imei: json['imei'] as String?,
    );

Map<String, dynamic> _$MbUserVoToJson(MbUserVo instance) => <String, dynamic>{
      'createTime': instance.createTime,
      'nickname': instance.nickname,
      'username': instance.username,
      'id': instance.id,
      'userNo': instance.userNo,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'withdrawPassword': instance.withdrawPassword,
      'pid': instance.pid,
      'invitationCode': instance.invitationCode,
      'role': instance.role,
      'accountFreeze': instance.accountFreeze,
      'lastLoginTime': instance.lastLoginTime,
      'imei': instance.imei,
    };

AppPasswordBo _$AppPasswordBoFromJson(Map<String, dynamic> json) =>
    AppPasswordBo(
      oldPassword: json['oldPassword'] as String,
      newPassword: json['newPassword'] as String,
      verificationCode: json['verificationCode'] as String?,
    );

Map<String, dynamic> _$AppPasswordBoToJson(AppPasswordBo instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'verificationCode': instance.verificationCode,
    };

AppUserUpdateBo _$AppUserUpdateBoFromJson(Map<String, dynamic> json) =>
    AppUserUpdateBo(
      phone: json['phone'] as String?,
      nickname: json['nickname'] as String?,
      avatar: json['avatar'] as String?,
      accountFreeze: json['accountFreeze'] as bool?,
      faceFinger: json['faceFinger'] as String?,
    );

Map<String, dynamic> _$AppUserUpdateBoToJson(AppUserUpdateBo instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'accountFreeze': instance.accountFreeze,
      'faceFinger': instance.faceFinger,
    };

EmailSendDto _$EmailSendDtoFromJson(Map<String, dynamic> json) => EmailSendDto(
      email: json['email'] as String,
    );

Map<String, dynamic> _$EmailSendDtoToJson(EmailSendDto instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

EmailBindDto _$EmailBindDtoFromJson(Map<String, dynamic> json) => EmailBindDto(
      email: json['email'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$EmailBindDtoToJson(EmailBindDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
