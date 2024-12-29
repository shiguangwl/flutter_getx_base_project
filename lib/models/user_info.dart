import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String? name;
  final int? age;

  const UserInfo({
    this.name,
    this.age,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo copyWith({
    String? name,
    int? age,
  }) {
    return UserInfo(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}
