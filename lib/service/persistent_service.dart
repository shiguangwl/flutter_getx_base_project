import 'package:get/get.dart';

import '../persistent/core/box_registry.dart';
import '../persistent/repository/auth_repository.dart';
import '../persistent/repository/config_repository.dart';
import '../persistent/repository/user_repository.dart';

/// 持久化服务
/// GetxService 门面，统一管理生命周期和各 Repository 访问
class PersistentService extends GetxService {
  static PersistentService get to => Get.find<PersistentService>();

  final BoxRegistry _boxRegistry = BoxRegistry();

  late final ConfigRepository config;
  late final AuthRepository auth;
  late final UserRepository user;

  static Future<void> init() async {
    final service = PersistentService();
    await service._initialize();
    Get.put<PersistentService>(service, permanent: true);
  }

  Future<void> _initialize() async {
    await _boxRegistry.init();
    config = ConfigRepository(_boxRegistry.configBox);
    auth = AuthRepository(_boxRegistry.secureBox);
    user = UserRepository();
  }

  /// 清除用户数据（退出登录）
  Future<void> clearUserData() async {
    await auth.clearTokens();
    await user.clearCurrentUser();
  }

  @override
  void onClose() {
    _boxRegistry.close();
    super.onClose();
  }
}
