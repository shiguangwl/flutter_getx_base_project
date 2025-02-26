import 'package:get/get.dart';
import '../models/user_model.dart';
import 'user_service.dart';

/// 认证服务
/// 处理用户登录、注册和认证状态管理
class AuthService extends GetxService {
  /// 登录状态
  final _isLoggedIn = false.obs;
  
  /// 当前登录用户
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  
  /// 获取登录状态
  bool get isLoggedIn => _isLoggedIn.value;
  
  /// 获取当前登录用户
  UserModel? get currentUser => _currentUser.value;
  
  /// 获取用户服务
  UserService get _userService => Get.find<UserService>();
  
  /// 初始化服务
  @override
  void onInit() {
    super.onInit();
    // 这里可以添加从本地存储加载用户登录状态的逻辑
  }
  
  /// 用户登录
  /// 
  /// [username] 用户名
  /// [password] 密码
  /// 
  /// 返回登录成功的用户模型，如果用户名或密码错误则抛出异常
  Future<UserModel> login(String username, String password) async {
    try {
      final user = await _userService.login(
        username: username,
        password: password,
      );
      
      // 更新登录状态和当前用户
      _isLoggedIn.value = true;
      _currentUser.value = user;
      
      // 这里可以添加保存用户登录状态到本地存储的逻辑
      
      return user;
    } catch (e) {
      rethrow;
    }
  }
  
  /// 用户注册
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
    try {
      return await _userService.register(
        username: username,
        password: password,
        email: email,
        phone: phone,
      );
    } catch (e) {
      rethrow;
    }
  }
  
  /// 用户登出
  void logout() {
    _isLoggedIn.value = false;
    _currentUser.value = null;
    
    // 这里可以添加清除本地存储中用户登录状态的逻辑
  }
  
  /// 更新当前用户信息
  Future<bool> updateCurrentUser(UserModel userModel) async {
    if (!isLoggedIn || _currentUser.value?.id != userModel.id) {
      throw Exception('用户未登录或ID不匹配');
    }
    
    final result = await _userService.updateUserInfo(userModel);
    if (result) {
      _currentUser.value = userModel;
    }
    
    return result;
  }
  
  /// 修改当前用户密码
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (!isLoggedIn || _currentUser.value?.id == null) {
      throw Exception('用户未登录');
    }
    
    return await _userService.changePassword(
      id: _currentUser.value!.id!,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}