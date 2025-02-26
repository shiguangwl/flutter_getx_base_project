import 'package:drift/drift.dart';

import '../database_service.dart';
import '../tables/tables.dart';

part 'user_dao.g.dart';

/// 用户数据访问对象
/// 处理用户相关的数据库操作
@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<DatabaseService> with _$UserDaoMixin {
  /// 构造函数
  UserDao(DatabaseService db) : super(db);
  
  /// 获取所有用户
  Future<List<User>> getAllUsers() {
    return select(users).get();
  }
  
  /// 根据ID获取用户
  Future<User?> getUserById(int id) {
    return (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  }
  
  /// 根据用户名获取用户
  Future<User?> getUserByUsername(String username) {
    return (select(users)..where((u) => u.username.equals(username))).getSingleOrNull();
  }
  
  /// 根据邮箱获取用户
  Future<User?> getUserByEmail(String email) {
    return (select(users)..where((u) => u.email.equals(email))).getSingleOrNull();
  }
  
  /// 创建用户
  Future<int> createUser(UsersCompanion user) {
    return into(users).insert(user);
  }
  
  /// 更新用户
  Future<bool> updateUser(UsersCompanion user) {
    return update(users).replace(user);
  }
  
  /// 删除用户（软删除）
  Future<int> softDeleteUser(int id) {
    return (update(users)..where((u) => u.id.equals(id)))
        .write(const UsersCompanion(isDeleted: Value(true)));
  }
  
  /// 删除用户（硬删除）
  Future<int> deleteUser(int id) {
    return (delete(users)..where((u) => u.id.equals(id))).go();
  }
  
  /// 更新用户最后登录时间
  Future<int> updateLastLoginTime(int id) {
    return (update(users)..where((u) => u.id.equals(id)))
        .write(UsersCompanion(lastLoginAt: Value(DateTime.now())));
  }
  
  /// 获取未删除的用户
  Future<List<User>> getActiveUsers() {
    return (select(users)..where((u) => u.isDeleted.equals(false))).get();
  }
  
  /// 搜索用户
  Future<List<User>> searchUsers(String query) {
    final lowerQuery = '%${query.toLowerCase()}%';
    return (select(users)
      ..where((u) => u.username.lower().like(lowerQuery) | u.email.lower().like(lowerQuery))
      ..where((u) => u.isDeleted.equals(false))
    ).get();
  }
} 