import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/base/state/page_constant.dart';
import '../../../../common/base/state/page_status_widget.dart';
import 'page_status_demo_logic.dart';

/// PageStatus 演示页面
/// 展示页面状态管理：loading、empty、error、success
class PageStatusDemoPage extends GetView<PageStatusDemoLogic> {
  const PageStatusDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PageStatus 演示'), centerTitle: true),
      body: Column(
        children: [
          _buildControlPanel(),
          const Divider(height: 1),
          Expanded(child: _buildStatusPreview()),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('手动切换状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Obx(() => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildStatusChip(PageState.loading, Icons.hourglass_empty),
                  _buildStatusChip(PageState.success, Icons.check_circle),
                  _buildStatusChip(PageState.empty, Icons.inbox),
                  _buildStatusChip(PageState.error, Icons.error),
                ],
              )),
          const SizedBox(height: 16),
          const Text('模拟场景',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: controller.simulateLoading,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('模拟加载成功'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: controller.simulateError,
                  icon: const Icon(Icons.warning),
                  label: const Text('模拟加载失败'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(PageState state, IconData icon) {
    final isSelected = controller.selectedStatus.value == state;
    final label = switch (state) {
      PageState.loading => '加载中',
      PageState.success => '成功',
      PageState.empty => '空数据',
      PageState.error => '错误',
    };

    return ChoiceChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _onStatusSelected(state),
    );
  }

  void _onStatusSelected(PageState state) {
    switch (state) {
      case PageState.loading:
        controller.setLoading();
      case PageState.success:
        controller.setSuccess();
      case PageState.empty:
        controller.setEmpty();
      case PageState.error:
        controller.setError();
    }
  }

  Widget _buildStatusPreview() {
    return Container(
      color: Colors.grey[100],
      child: PageStatusWidget(
        controller: controller.statusController,
        childBuilder: () => _buildSuccessContent(),
        customLoadingBuilder: (_) => _buildCustomLoading(),
        customEmptyBuilder: (_) => _buildCustomEmpty(),
        customErrorBuilder: (onRetry, error) =>
            _buildCustomError(onRetry, error),
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 80, color: Colors.green[400]),
          const SizedBox(height: 16),
          const Text('加载成功！', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('这里是正常的页面内容', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildCustomLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('正在加载中...'),
        ],
      ),
    );
  }

  Widget _buildCustomEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('暂无数据', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('空空如也~', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildCustomError(VoidCallback? onRetry, PageError? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(error?.message ?? '加载失败', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('点击重试'),
          ),
        ],
      ),
    );
  }
}
