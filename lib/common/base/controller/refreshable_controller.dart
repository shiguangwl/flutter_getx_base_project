import '../refresh/page_refreshable_controller.dart';
import '../state/page_constant.dart';
import '../state/page_status_controller.dart';
import '../view/abstract_base.dart';

/// 可刷新控制器类
/// 提供列表数据的分页加载和刷新功能
/// 不依赖页面状态管理，专注于列表数据处理
abstract class RefreshableController<T> extends AbstractBaseController {
  late PageStatusController pageCtrl;
  late PageRefreshableController<T> listCtrl;

  /// 是否为第一次刷新
  bool isFirstRefresh = true;

  /// List区域的状态控制器。
  PageStatusController get listPageCtrl => listCtrl.pageCtrl;

  /// 重新加载页面
  void reloadPage() {
    pageCtrl.startLoadPage();
  }

  /// 重新加载列表
  void reloadList() {
    listPageCtrl.startLoadPage();
  }

  /// 触发列表刷新
  void triggerListRefresh() {
    listCtrl.triggerRefreshIndicator();
  }

  /// 触发列表加载更多
  void triggerListLoadMore() {
    listCtrl.triggerLoadMoreIndicator();
  }

  @override
  void onInit() {
    super.onInit();
    pageCtrl = PageStatusController(() async {
      isFirstRefresh = true;
      return await onLoadPage();
    });

    listCtrl = PageRefreshableController<T>(
      (page, pageSize) async {
        if (isFirstRefresh == false && page == 1) {
          await onManualRefresh();
        }
        if (isFirstRefresh) {
          isFirstRefresh = false;
        }
        return await dataFetcher(page, pageSize);
      },
    );
  }

  /// 手动下拉刷新触发（排除第一次页面加载）
  Future<void> onManualRefresh() {
    return Future.value(null);
  }

  /// 页面加载，一些前置操作可以在此处实现
  Future<PageResult> onLoadPage();

  /// 列表数据加载
  Future<List<T>> dataFetcher(int page, int pageSize);

  @override
  void onClose() {
    pageCtrl.dispose();
    listCtrl.dispose();
    super.onClose();
  }
}
