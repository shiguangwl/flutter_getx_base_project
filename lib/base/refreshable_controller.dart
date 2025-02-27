import 'package:get/get.dart';
import 'BaseController.dart';

/// 支持下拉刷新和上拉加载更多的控制器基类
abstract class RefreshableController extends BaseController {
  /// 是否正在加载更多
  final RxBool isLoadingMore = false.obs;
  
  /// 是否还有更多数据
  final RxBool hasMore = true.obs;
  
  /// 当前页码
  int currentPage = 1;
  
  /// 每页数据量
  final int pageSize = 20;

  @override
  Future<void> loadData(bool isLoadMore);

  /// 下拉刷新
  Future<void> onRefresh() async {
    try {
      currentPage = 1;
      hasMore.value = true;
      await loadData(false);
      success();
    } catch (e) {
      error();
    }
  }

  /// 上拉加载更多
  Future<void> onLoadMore() async {
    if (!hasMore.value || isLoadingMore.value) return;
    
    try {
      isLoadingMore.value = true;
      currentPage++;
      await loadData(true);
      isLoadingMore.value = false;
    } catch (e) {
      isLoadingMore.value = false;
      currentPage--;
      error();
    }
  }

  /// 检查是否还有更多数据
  /// [total] 总数据量
  void checkHasMore(int total) {
    hasMore.value = total >= pageSize;
  }
} 