import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/tables.dart';
import 'daos/user_dao.dart';

part 'database_service.g.dart';

/// 数据库服务类
/// 使用drift作为SQLite的ORM工具
@DriftDatabase(tables: [
  // 在这里添加所有的表
  Users,
], daos: [
  // 在这里添加所有的DAO
  UserDao,
])
class DatabaseService extends _$DatabaseService {
  /// 单例实例
  static final DatabaseService _instance = DatabaseService._internal();
  
  /// 工厂构造函数
  factory DatabaseService() => _instance;
  
  /// 内部构造函数
  DatabaseService._internal() : super(_openConnection());
  
  /// 数据库版本
  @override
  int get schemaVersion => 1;
  
  /// 数据库迁移
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // 在这里处理数据库版本升级
        if (from < 2) {
          // 版本1升级到版本2的迁移代码
        }
      },
      beforeOpen: (details) async {
        // 数据库打开前的操作
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
  
  /// 初始化数据库
  Future<void> init() async {
    // 数据库已经在构造函数中初始化，这里可以添加额外的初始化逻辑
  }
  
  /// 关闭数据库连接
  Future<void> close() async {
    await super.close();
  }
  
  /// 清空数据库中的所有数据
  Future<void> clearAllData() async {
    await transaction(() async {
      // 清空所有表的数据
      await delete(users).go();
      // 添加其他表的清空操作
    });
  }
}

/// 打开数据库连接
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // 获取文档目录
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    
    // 返回数据库连接
    return NativeDatabase.createInBackground(file);
  });
} 