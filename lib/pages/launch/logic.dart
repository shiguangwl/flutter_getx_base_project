import 'package:lanyu_chat/routes/router.dart';
import 'package:get/get.dart';

import '../../base/BaseController.dart';

class LaunchLogic extends BaseController {

  @override
  void onClose() {}

  @override
  void onReady() async {
    loadData(false);
  }


  /// 在错误从试会自动调用
  @override
  void loadData(bool isLoadMore) async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(AppRoutes.Home);
  }
}