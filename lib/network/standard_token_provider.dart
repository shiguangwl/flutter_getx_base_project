import 'package:get/get.dart';
import 'package:liushui_app/routes/router.dart';

import '../common/network/config/http_config.dart';
import '../service/persistent_service.dart';

class StandardTokenProvider extends TokenProvider {
  PersistentService get _persistent => PersistentService.to;

  @override
  Future<String?> getToken() async {
    return _persistent.auth.getAccessToken();
  }

  @override
  void onRefreshTokenFailed(info) {
    Get.offAllNamed(AppRoutes.Login);
  }

  @override
  Future<void> refreshToken() async {
    await _persistent.auth.clearTokens();
  }
}
