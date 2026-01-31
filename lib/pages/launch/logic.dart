import 'package:get/get.dart';

import '../../common/base/controller/base_controller.dart';
import '../../common/base/state/page_constant.dart';
import '../../routes/router.dart';
import '../../service/api_service/user_service.dart';

class LaunchLogic extends BaseController {
  static LaunchLogic get to => Get.find<LaunchLogic>();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 1));
    if (UserService.to.hasToken) {
      Get.offAllNamed(AppRoutes.Home);
    } else {
      Get.offAllNamed(AppRoutes.Login);
    }
  }

  @override
  Future<PageResult> onLoadPage() async {
    return const PageSuccess();
  }
}
