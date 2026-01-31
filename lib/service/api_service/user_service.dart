import 'package:get/get.dart';

import '../persistent_service.dart';

class UserService extends GetxService {
  static UserService get to => Get.find<UserService>();

  PersistentService get _persistent => PersistentService.to;

  bool get hasToken => _persistent.auth.hasToken();

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    await _persistent.auth.saveAccessToken("Token123456789");
    return true;
  }

  Future<void> logout() async {
    await _persistent.clearUserData();
  }

  @override
  void onClose() {
    super.onClose();
    _persistent.auth.clearTokens();
  }
}
