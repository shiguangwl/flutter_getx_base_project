import 'package:json_annotation/json_annotation.dart';

part 'upload_models.g.dart';

/// 文件上传响应对象
@JsonSerializable()
class SysOssUploadVo {
  /// URL地址
  @JsonKey(name: 'url')
  final String? url;

  /// 文件名
  @JsonKey(name: 'fileName')
  final String? fileName;

  /// 对象存储主键
  @JsonKey(name: 'ossId')
  final String? ossId;

  const SysOssUploadVo({
    this.url,
    this.fileName,
    this.ossId,
  });

  factory SysOssUploadVo.fromJson(Map<String, dynamic> json) =>
      _$SysOssUploadVoFromJson(json);

  Map<String, dynamic> toJson() => _$SysOssUploadVoToJson(this);
}
