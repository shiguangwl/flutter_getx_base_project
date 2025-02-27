import 'package:drift/drift.dart';
import 'package:lanyu_chat/persistent/database/daos/user_dao.dart';

import '../models/user_model.dart';
import '../persistent/persistent_service.dart';
import '../persistent/database/database_service.dart';
import '../utils/crypto_util.dart';

/// 用户服务
/// 处理用户相关的业务逻辑
class UserService {
  /// 单例实例
  static final UserService _instance = UserService._internal();
  
  /// 工厂构造函数
  factory UserService() => _instance;
  
  /// 内部构造函数
  UserService._internal();
  
  /// 获取数据库服务
  DatabaseService get _db => PersistentService().database;
  
  /// 获取用户DAO
  UserDao get _userDao => _db.userDao;
  
  /// 注册用户
  /// 
  /// [username] 用户名
  /// [password] 密码
  /// [email] 邮箱（可选）
  /// [phone] 手机号（可选）
  /// 
  /// 返回注册成功的用户ID，如果用户名已存在则抛出异常
  Future<int> register({
    required String username,
    required String password,
    String? email,
    String? phone,
  }) async {
    // 检查用户名是否已存在
    final existingUser = await _userDao.getUserByUsername(username);
    if (existingUser != null) {
      throw Exception('用户名已存在');
    }
    
    // 检查邮箱是否已存在
    if (email != null && email.isNotEmpty) {
      final existingEmail = await _userDao.getUserByEmail(email);
      if (existingEmail != null) {
        throw Exception('邮箱已被使用');
      }
    }
    
    // 创建用户模型
    final userModel = UserModel(
      username: username,
      email: email,
      phone: phone,
    );
    
    // 密码加密
    final passwordHash = CryptoUtil.hashPassword(password);
    
    // 插入数据库
    return await _userDao.createUser(
      userModel.toInsertCompanion(passwordHash: passwordHash),
    );
  }
  
  /// 用户登录
  /// 
  /// [username] 用户名
  /// [password] 密码
  /// 
  /// 返回登录成功的用户模型，如果用户名或密码错误则抛出异常
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    // 获取用户
    final user = await _userDao.getUserByUsername(username);
    if (user == null) {
      throw Exception('用户名或密码错误');
    }
    
    // 验证密码
    if (!CryptoUtil.verifyPassword(password, user.passwordHash)) {
      throw Exception('用户名或密码错误');
    }
    
    // 更新最后登录时间
    await _userDao.updateLastLoginTime(user.id);
    
    // 返回用户模型
    return UserModel.fromEntity(user);
  }
  
  /// 获取用户信息
  /// 
  /// [id] 用户ID
  /// 
  /// 返回用户模型，如果用户不存在则返回null
  Future<UserModel?> getUserInfo(int id) async {
    final user = await _userDao.getUserById(id);
    if (user == null) {
      return null;
    }
    return UserModel.fromEntity(user);
  }
  
  /// 更新用户信息
  /// 
  /// [userModel] 用户模型
  /// 
  /// 返回是否更新成功
  Future<bool> updateUserInfo(UserModel userModel) async {
    if (userModel.id == null) {
      throw Exception('用户ID不能为空');
    }
    
    return await _userDao.updateUser(userModel.toCompanion());
  }
  
  /// 修改密码
  /// 
  /// [id] 用户ID
  /// [oldPassword] 旧密码
  /// [newPassword] 新密码
  /// 
  /// 返回是否修改成功，如果旧密码错误则抛出异常
  Future<bool> changePassword({
    required int id,
    required String oldPassword,
    required String newPassword,
  }) async {
    // 获取用户
    final user = await _userDao.getUserById(id);
    if (user == null) {
      throw Exception('用户不存在');
    }
    
    // 验证旧密码
    if (!CryptoUtil.verifyPassword(oldPassword, user.passwordHash)) {
      throw Exception('旧密码错误');
    }
    
    // 生成新密码哈希
    final newPasswordHash = CryptoUtil.hashPassword(newPassword);
    
    // 更新密码
    return await _userDao.updateUser(
      UsersCompanion(
        id: Value(id),
        passwordHash: Value(newPasswordHash),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
  
  /// 删除用户（软删除）
  /// 
  /// [id] 用户ID
  /// 
  /// 返回是否删除成功
  Future<bool> deleteUser(int id) async {
    final result = await _userDao.softDeleteUser(id);
    return result > 0;
  }
  
  /// 搜索用户
  /// 
  /// [query] 搜索关键词
  /// 
  /// 返回匹配的用户列表
  Future<List<UserModel>> searchUsers(String query) async {
    final users = await _userDao.searchUsers(query);
    return users.map((user) => UserModel.fromEntity(user)).toList();
  }


  
} 