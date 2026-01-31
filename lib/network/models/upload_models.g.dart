// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SysOssUploadVo _$SysOssUploadVoFromJson(Map<String, dynamic> json) =>
    SysOssUploadVo(
      url: json['url'] as String?,
      fileName: json['fileName'] as String?,
      ossId: json['ossId'] as String?,
    );

Map<String, dynamic> _$SysOssUploadVoToJson(SysOssUploadVo instance) =>
    <String, dynamic>{
      'url': instance.url,
      'fileName': instance.fileName,
      'ossId': instance.ossId,
    };
