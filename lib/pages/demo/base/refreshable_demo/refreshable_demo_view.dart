import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/base/config/view_config.dart';
import '../../../../common/base/config/refresh_position.dart';
import '../../../../common/base/view/refreshable_view.dart';
import 'refreshable_demo_logic.dart';

/// RefreshableView 演示页面
/// 展示下拉刷新、上拉加载、头部配置等功能
class RefreshableDemoPage
    extends RefreshableView<RefreshableDemoLogic, DemoItem> {
  const RefreshableDemoPage({super.key});

  /// 配置刷新行为
  /// enableDownRefresh: 启用下拉刷新
  /// enableUpRefresh: 启用上拉加载更多
  /// refreshPosition: 刷新指示器位置（头部上方/下方）
  /// pinHeader: 是否固定头部
  @override
  RefreshableConfig get viewConfig => RefreshableConfig(
        enableDownRefresh: true,
        enableUpRefresh: true,
        refreshPosition: RefreshPosition.aboveHeader,
        pinHeader: false,
      );

  @override
  PreferredSizeWidget? buildAppBar() {
    return AppBar(
      title: const Text('RefreshableView 演示'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: _showConfigInfo,
        ),
      ],
    );
  }

  /// 构建列表头部
  @override
  Widget? buildHeadView() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('列表头部区域',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 8),
          Text('下拉刷新或上拉加载更多', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  /// 当 pinHeader 为 true 时必须实现此方法
  @override
  int headViewHeight() => 120;

  /// 构建列表项
  @override
  Widget buildListItem(List<DemoItem> items, DemoItem item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child:
              Text('${item.id}', style: TextStyle(color: Colors.blue.shade700)),
        ),
        title: Text(item.title),
        subtitle: Text(item.subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  void _showConfigInfo() {
    showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        title: const Text('当前配置'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('下拉刷新: ${viewConfig.enableDownRefresh ? "✅ 启用" : "❌ 禁用"}'),
            Text('上拉加载: ${viewConfig.enableUpRefresh ? "✅ 启用" : "❌ 禁用"}'),
            Text('刷新位置: ${viewConfig.refreshPosition.name}'),
            Text('固定头部: ${viewConfig.pinHeader ? "✅ 是" : "❌ 否"}'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('确定')),
        ],
      ),
    );
  }
}
