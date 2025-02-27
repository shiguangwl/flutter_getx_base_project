import 'package:get/get.dart';
import '../../base/refreshable_controller.dart';

class ExampleListController extends RefreshableController {
  final RxList<String> items = <String>[].obs;

  @override
  Future<void> loadData(bool isLoadMore) async {
    // 模拟网络请求延迟
    await Future.delayed(const Duration(seconds: 1));
    
    // 模拟数据
    final List<String> newItems = List.generate(
      20,
      (index) => '第${currentPage}页 - 第${index + 1}项',
    );
    
    if (isLoadMore) {
      items.addAll(newItems);
    } else {
      items.value = newItems;
    }
    
    // 检查是否还有更多数据
    checkHasMore(newItems.length);
    success();
  }

  @override
  void onInit() {
    super.onInit();
    loadData(false);
  }
} 