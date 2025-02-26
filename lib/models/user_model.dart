import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';

import '../persistent/database/database_service.dart';

part 'user_model.g.dart';

/// 用户模型
/// 用于前端展示和业务逻辑处理
@JsonSerializable()
class UserModel {
  /// 用户ID
  final int? id;
  
  /// 用户名
  final String username;
  
  /// 邮箱
  final String? email;
  
  /// 手机号
  final String? phone;
  
  /// 头像URL
  final String? avatarUrl;
  
  /// 创建时间
  final DateTime? createdAt;
  
  /// 更新时间
  final DateTime? updatedAt;
  
  /// 最后登录时间
  final DateTime? lastLoginAt;
  
  /// 构造函数
  UserModel({
    this.id,
    required this.username,
    this.email,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
  });
  
  /// 从JSON创建用户模型
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  /// 转换为JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  
  /// 从数据库实体创建用户模型
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      phone: entity.phone,
      avatarUrl: entity.avatarUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      lastLoginAt: entity.lastLoginAt,
    );
  }
  
  /// 转换为数据库实体的Companion对象（用于插入或更新）
  UsersCompanion toCompanion() {
    return UsersCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      username: Value(username),
      email: email == null ? const Value.absent() : Value(email!),
      phone: phone == null ? const Value.absent() : Value(phone!),
      avatarUrl: avatarUrl == null ? const Value.absent() : Value(avatarUrl!),
      updatedAt: Value(DateTime.now()),
    );
  }
  
  /// 创建一个新的用户模型，用于插入数据库
  UsersCompanion toInsertCompanion({required String passwordHash}) {
    return UsersCompanion.insert(
      username: username,
      passwordHash: passwordHash,
      email: Value(email),
      phone: Value(phone),
      avatarUrl: Value(avatarUrl),
    );
  }
  
  /// 复制用户模型并修改部分属性
  UserModel copyWith({
    int? id,
    String? username,
    String? email,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
} 