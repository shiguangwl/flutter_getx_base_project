/// 页面状态
abstract class AbstractPageStatus {
  late PageState state;

  /// 加载网络数据
  void loadData();
}

enum PageState {
  LOADING,
  SUCCESS,
  ERROR,
  EMPTY,
}
