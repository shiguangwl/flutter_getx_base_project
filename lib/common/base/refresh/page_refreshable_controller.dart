import 'dart:async';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../../log/logger.dart';
import '../state/page_constant.dart';
import '../state/page_status_controller.dart';

/// 数据获取函数的类型定义。
///
/// 接收[page]页码和[pageSize]大小，异步返回数据列表[List<T>]。
typedef PageFetcher<T> = Future<List<T>> Function(int page, int pageSize);

/// 列表的加载状态枚举。
enum LoadStatus {
  idle, // 空闲
  loading, // 首次加载
  refreshing, // 下拉刷新
  loadingMore, // 上拉加载更多
}

/// 内部状态快照，用于加载失败时回滚。
class _ListStateSnapshot<T> {
  final int page;
  final List<T> items;
  final bool hasMore;

  const _ListStateSnapshot({
    required this.page,
    required this.items,
    required this.hasMore,
  });

  /// 将快照中的状态恢复到响应式变量。
  void restore(RxInt pageRx, RxList<T> itemsRx, RxBool hasMoreRx) {
    pageRx.value = page;
    itemsRx.assignAll(items);
    hasMoreRx.value = hasMore;
  }

  @override
  String toString() => 'page=$page, count=${items.length}, hasMore=$hasMore';
}

class PageRefreshableController<T> extends GetxController {
  /// EasyRefresh的控制器
  final EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  /// 页面级状态控制器(加载中、内容、空、错误)。
  late final PageStatusController _pageStatusController;

  /// 外部注入的数据获取逻辑
  final PageFetcher<T> _dataFetcher;

  /// 每页数据量。
  final int _pageSize;

  final RxInt _currentPage = 0.obs; // 当前页码
  final RxList<T> _items = <T>[].obs; // 数据列表
  final Rx<LoadStatus> _status = LoadStatus.idle.obs; // 加载状态
  final RxBool _hasMore = true.obs; // 是否还有更多数据

  PageRefreshableController(PageFetcher<T> dataFetcher, {int pageSize = 20})
      : _dataFetcher = dataFetcher,
        _pageSize = pageSize {
    _pageStatusController = PageStatusController(onLoadPage);
  }

  /// 创建当前状态的快照。
  _ListStateSnapshot<T> _createSnapshot() {
    return _ListStateSnapshot<T>(
      page: _currentPage.value,
      items: List<T>.from(_items),
      hasMore: _hasMore.value,
    );
  }

  /// 核心数据获取逻辑，封装了分页、状态更新和异常回滚。
  Future<List<T>> _fetchData({required bool isRefresh}) async {
    final snapshot = _createSnapshot();

    final int nextPage = isRefresh ? 1 : _currentPage.value + 1;
    Log.d(
      '[PageRefreshableController] 开始请求: ${isRefresh ? '刷新' : '加载更多'}, page=$nextPage',
    );

    try {
      final List<T> fetchedData = await _dataFetcher(nextPage, _pageSize);

      if (isRefresh) {
        _items.assignAll(fetchedData);
      } else {
        _items.addAll(fetchedData);
      }
      _currentPage.value = nextPage;
      _hasMore.value = fetchedData.length >= _pageSize;

      return fetchedData;
    } catch (e, s) {
      Log.e('[PageRefreshableController] 列表数据加载失败，执行回滚', e, s);
      snapshot.restore(_currentPage, _items, _hasMore);
      Log.d('[PageRefreshableController] 已恢复到快照: $snapshot');
      rethrow;
    }
  }

  /// 页面首次加载/重试时由 [PageStatusController] 调用。
  Future<PageResult> onLoadPage() async {
    if (_status.value != LoadStatus.idle) return const PageSuccess();
    _status.value = LoadStatus.loading;

    try {
      final data = await _fetchData(isRefresh: true);
      return data.isEmpty ? const PageEmpty() : const PageSuccess();
    } catch (e) {
      return const PageFailure(PageError.unknownError);
    } finally {
      _status.value = LoadStatus.idle;
    }
  }

  Future<void> doRefresh() async {
    if (_status.value != LoadStatus.idle) return;
    _status.value = LoadStatus.refreshing;

    try {
      final data = await _fetchData(isRefresh: true);
      if (data.isEmpty) {
        _pageStatusController.setEmpty();
      } else {
        _pageStatusController.setSuccess();
      }
      _easyRefreshController.finishRefresh(IndicatorResult.success);
      _easyRefreshController.resetFooter();
    } catch (e) {
      Log.e('[PageRefreshableController] 刷新失败', e);
      _easyRefreshController.finishRefresh(IndicatorResult.fail);
    } finally {
      _status.value = LoadStatus.idle;
    }
  }

  Future<void> loadMore() async {
    if (_status.value != LoadStatus.idle || !_hasMore.value) return;
    _status.value = LoadStatus.loadingMore;

    try {
      await _fetchData(isRefresh: false);
      _easyRefreshController.finishLoad(
        _hasMore.value ? IndicatorResult.success : IndicatorResult.noMore,
      );
    } catch (e) {
      Log.e('[PageRefreshableController] 加载更多失败', e);
      _easyRefreshController.finishLoad(IndicatorResult.fail);
    } finally {
      _status.value = LoadStatus.idle;
    }
  }

  /// 手动触发下拉刷新动画
  void triggerRefreshIndicator() {
    _easyRefreshController.callRefresh();
  }

  /// 手动触发上拉加载动画
  void triggerLoadMoreIndicator() {
    if (!_hasMore.value) return;
    _easyRefreshController.callLoad();
  }

  @override
  void onClose() {
    _easyRefreshController.dispose();
    super.onClose();
    Log.d('[PageRefreshableController] Disposed');
  }

  // 列表数据直接操作
  void addItem(T item) => _items.insert(0, item);
  void removeItem(T item) => _items.remove(item);
  void updateItem(int index, T item) {
    if (index < 0 || index >= _items.length) {
      throw RangeError('Index out of range: $index');
    }
    _items[index] = item;
  }

  // 响应式变量
  RxList<T> get itemsRx => _items;
  Rx<LoadStatus> get statusRx => _status;
  RxBool get hasMoreRx => _hasMore;

  // 普通值
  List<T> get items => _items.toList();
  bool get hasMore => _hasMore.value;
  PageStatusController get pageCtrl => _pageStatusController;
  EasyRefreshController get listCtrl => _easyRefreshController;

  // 计算属性
  bool get isLoading => _status.value == LoadStatus.loading;
  bool get isRefreshing => _status.value == LoadStatus.refreshing;
  bool get isLoadingMore => _status.value == LoadStatus.loadingMore;

  bool get isEmpty => _items.isEmpty && !isLoading;
  bool get hasData => _items.isNotEmpty;
}
