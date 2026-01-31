import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@HiveType(typeId: 0)
class UserModel with _$UserModel {
  const factory UserModel({
    @HiveField(0) required int id,
    @HiveField(1) required String username,
    @HiveField(2) String? email,
    @HiveField(3) String? phone,
    @HiveField(4) String? avatarUrl,
    @HiveField(5) DateTime? createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) DateTime? lastLoginAt,
    @HiveField(8, defaultValue: false) @Default(false) bool isDeleted,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
