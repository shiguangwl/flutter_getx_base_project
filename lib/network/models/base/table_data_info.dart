import 'package:json_annotation/json_annotation.dart';
import '../../../common/network/exception/api_exception.dart';
part 'table_data_info.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class TableDataInfo<T> {
  final int total;
  final List<T> rows;
  final int code;
  final String msg;

  TableDataInfo({
    required this.total,
    required this.rows,
    required this.code,
    required this.msg,
  });

  factory TableDataInfo.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$TableDataInfoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$TableDataInfoToJson(this, toJsonT);

  ApiException toException({dynamic cause}) =>
      ApiException(code: code, message: msg, cause: this);
}
