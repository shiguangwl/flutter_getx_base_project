import '../../../../common/base/controller/refreshable_controller.dart';
import '../../../../common/base/state/page_constant.dart';

/// 演示数据模型
class DemoItem {
  final int id;
  final String title;
  final String subtitle;

  DemoItem({required this.id, required this.title, required this.subtitle});
}

/// RefreshableView 演示控制器
class RefreshableDemoLogic extends RefreshableController<DemoItem> {
  // 模拟数据总量
  static const int _totalItems = 50;

  @override
  Future<PageResult> onLoadPage() async {
    // 页面加载时的前置操作（如获取配置等）
    await Future.delayed(const Duration(milliseconds: 300));
    return const PageSuccess();
  }

  @override
  Future<void> onManualRefresh() async {
    // 手动下拉刷新时额外执行的逻辑（不包括首次加载）
  }

  @override
  Future<List<DemoItem>> dataFetcher(int page, int pageSize) async {
    // 模拟网络请求延迟
    await Future.delayed(const Duration(milliseconds: 800));

    // 计算当前页的起始索引
    final startIndex = (page - 1) * pageSize;
    if (startIndex >= _totalItems) {
      return []; // 没有更多数据
    }

    // 生成模拟数据
    final endIndex = (startIndex + pageSize > _totalItems)
        ? _totalItems
        : startIndex + pageSize;

    return List.generate(
      endIndex - startIndex,
      (index) => DemoItem(
        id: startIndex + index + 1,
        title: '列表项 ${startIndex + index + 1}',
        subtitle: '这是第 $page 页的数据，索引 ${index + 1}',
      ),
    );
  }
}
