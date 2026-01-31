// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_data_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableDataInfo<T> _$TableDataInfoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    TableDataInfo<T>(
      total: (json['total'] as num).toInt(),
      rows: (json['rows'] as List<dynamic>).map(fromJsonT).toList(),
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$TableDataInfoToJson<T>(
  TableDataInfo<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows.map(toJsonT).toList(),
      'code': instance.code,
      'msg': instance.msg,
    };
