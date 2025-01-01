
import '../../../base/BaseController.dart';

class HomeLogic extends BaseController {

  @override
  void onClose() {}

  @override
  void onReady() async {
    loadData();
  }


  /// 在错误从试会自动调用
  @override
  void loadData() {
    // 延迟3秒
    Future.delayed(const Duration(seconds: 3), () {
      error();
    });
  }
}