import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routing_demo_logic.dart';

/// 路由演示页面
/// 展示 GetX 路由的各种导航方式
class RoutingDemoPage extends GetView<RoutingDemoLogic> {
  const RoutingDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('路由演示'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: controller.getCurrentRoute,
            tooltip: '路由信息',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: controller.clearLogs,
            tooltip: '清空日志',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildNavigationPanel(),
          const Divider(height: 1),
          Expanded(child: _buildLogPanel()),
        ],
      ),
    );
  }

  Widget _buildNavigationPanel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('基础导航', [
            _NavButton('toNamed', Colors.blue, controller.navigateToTarget),
            _NavButton('带参数', Colors.green, controller.navigateWithArguments),
            _NavButton(
                'URL参数', Colors.teal, controller.navigateWithQueryParams),
          ]),
          const SizedBox(height: 16),
          _buildSection('高级导航', [
            _NavButton('替换页面', Colors.orange, controller.navigateAndReplace),
            _NavButton('清空栈', Colors.red, controller.navigateAndClearStack),
            _NavButton('等待结果', Colors.purple, controller.navigateForResult),
          ]),
          const SizedBox(height: 16),
          _buildSection('返回操作', [
            _NavButton('返回', Colors.grey, controller.goBack),
            _NavButton('返回首页', Colors.blueGrey, controller.backUntil),
            _NavButton('检查路由', Colors.indigo, controller.checkRouteExists),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<_NavButton> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: buttons
              .map((b) => ElevatedButton(
                    onPressed: b.onPressed,
                    style: ElevatedButton.styleFrom(backgroundColor: b.color),
                    child: Text(b.label,
                        style: const TextStyle(color: Colors.white)),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildLogPanel() {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('操作日志', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() => controller.logs.isEmpty
                ? Center(
                    child: Text('点击上方按钮测试路由',
                        style: TextStyle(color: Colors.grey[600])))
                : ListView.builder(
                    itemCount: controller.logs.length,
                    itemBuilder: (_, index) {
                      final log = controller.logs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(log,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: Colors.grey[800],
                            )),
                      );
                    },
                  )),
          ),
        ],
      ),
    );
  }
}

class _NavButton {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  _NavButton(this.label, this.color, this.onPressed);
}
