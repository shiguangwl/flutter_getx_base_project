import 'package:get/get.dart';

import '../../../common/base/controller/base_controller.dart';
import '../../../common/base/state/page_constant.dart';
import '../../../routes/router.dart';
import '../../../service/api_service/user_service.dart';

class MyLogic extends BaseController {
  static MyLogic get to => Get.find<MyLogic>();

  final RxString username = '用户'.obs;
  final RxString userId = '123456'.obs;

  @override
  Future<PageResult> onLoadPage() async {
    // Scaffold 模式下，简单设置一下
    return const PageSuccess();
  }

  void logout() {
    UserService.to.logout();
    Get.offAllNamed(AppRoutes.Login);
  }
}
