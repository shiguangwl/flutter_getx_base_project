import 'package:drift/drift.dart';

/// 用户表定义
class Users extends Table {
  /// 用户ID，自增主键
  IntColumn get id => integer().autoIncrement()();
  
  /// 用户名
  TextColumn get username => text().withLength(min: 1, max: 50)();
  
  /// 密码哈希
  TextColumn get passwordHash => text()();
  
  /// 邮箱
  TextColumn get email => text().nullable()();
  
  /// 手机号
  TextColumn get phone => text().nullable()();
  
  /// 头像URL
  TextColumn get avatarUrl => text().nullable()();
  
  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))();
  
  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(Constant(DateTime.now()))();
  
  /// 最后登录时间
  DateTimeColumn get lastLoginAt => dateTime().nullable()();
  
  /// 是否已删除
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
} 