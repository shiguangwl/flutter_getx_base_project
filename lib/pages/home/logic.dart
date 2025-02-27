
import '../../../base/BaseController.dart';

class HomeLogic extends BaseController {

  @override
  void onClose() {}

  @override
  void onReady() async {
    loadData(false);
  }


  /// 在错误从试会自动调用
  /// @param isLoadMore 是否是加载更多
  @override
  void loadData(bool isLoadMore) {
    success();
  }
}