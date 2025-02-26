# Flutter 基于getX,dio,retrofit,hive,isar....快速开发脚手架模板

# 关于持久化-数据库服务


使用 [drift](https://drift.simonbinder.eu/) 作为 SQLite 的 ORM 工具。

## 生成代码

在修改了数据库相关的代码后，需要运行以下命令生成必要的代码文件：

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

或者使用 watch 模式，自动监听文件变化并生成代码：

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 文件结构

- `database_service.dart`: 数据库服务类，负责初始化和管理数据库连接
- `tables/`: 包含所有表定义
  - `tables.dart`: 导出所有表定义
  - `users_table.dart`: 用户表定义
- `daos/`: 包含所有数据访问对象（DAO）
  - `user_dao.dart`: 用户数据访问对象，处理用户相关的数据库操作

## 使用示例

```dart
// 获取数据库服务
final db = PersistentService().database;

// 使用用户DAO
final userDao = db.userDao;

// 创建用户
final userId = await userDao.createUser(
  UsersCompanion.insert(
    username: 'test_user',
    passwordHash: 'hashed_password',
    email: Value('test@example.com'),
  ),
);

// 获取用户
final user = await userDao.getUserById(userId);

// 更新用户
await userDao.updateUser(
  UsersCompanion(
    id: Value(userId),
    email: Value('new_email@example.com'),
  ),
);

// 删除用户（软删除）
await userDao.softDeleteUser(userId);
``` 