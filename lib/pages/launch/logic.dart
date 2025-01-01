
import 'package:flutter_getx_base_project/routes/router.dart';
import 'package:get/get.dart';

import '../../base/BaseController.dart';

class LaunchLogic extends BaseController {

  @override
  void onClose() {}

  @override
  void onReady() async {
    loadData();
  }


  /// 在错误从试会自动调用
  @override
  void loadData() async {
    // 延迟3秒
    await Future.delayed(const Duration(seconds: 3));
    // error();
    Get.offNamed(AppRoutes.Home);
  }
}