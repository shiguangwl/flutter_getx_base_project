// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppRegisterBo _$AppRegisterBoFromJson(Map<String, dynamic> json) =>
    AppRegisterBo(
      username: json['username'] as String,
      password: json['password'] as String,
      inviteCode: json['inviteCode'] as String,
      roleEnum: json['roleEnum'] as String?,
    );

Map<String, dynamic> _$AppRegisterBoToJson(AppRegisterBo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'inviteCode': instance.inviteCode,
      'roleEnum': instance.roleEnum,
    };

AppLoginBo _$AppLoginBoFromJson(Map<String, dynamic> json) => AppLoginBo(
      username: json['username'] as String,
      password: json['password'] as String,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$AppLoginBoToJson(AppLoginBo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'deviceId': instance.deviceId,
    };

AppLoginVo _$AppLoginVoFromJson(Map<String, dynamic> json) => AppLoginVo(
      uid: (json['uid'] as num).toInt(),
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      expireIn: (json['expireIn'] as num).toInt(),
      loginTime: (json['loginTime'] as num).toInt(),
    );

Map<String, dynamic> _$AppLoginVoToJson(AppLoginVo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expireIn': instance.expireIn,
      'loginTime': instance.loginTime,
    };
