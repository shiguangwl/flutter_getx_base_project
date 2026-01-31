import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/base/view/base_view.dart';
import 'base_view_demo_logic.dart';

/// BaseView 演示页面
/// 展示 BaseView + BaseController 的基本用法
class BaseViewDemoPage extends BaseView<BaseViewDemoLogic> {
  const BaseViewDemoPage({super.key});

  @override
  PreferredSizeWidget? buildAppBar() {
    return AppBar(title: const Text('BaseView 演示'), centerTitle: true);
  }

  @override
  Widget buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('基本说明', _buildDescription()),
          const SizedBox(height: 20),
          _buildSection('Controller 数据绑定', _buildDataBinding()),
          const SizedBox(height: 20),
          _buildSection('GetBuilder 使用', _buildGetBuilderDemo()),
          const SizedBox(height: 20),
          _buildSection('可重写方法', _buildOverrideMethods()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildDescription() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• BaseView 继承自 AbstractBaseView'),
            SizedBox(height: 8),
            Text('• 自动集成 PageStatusWidget 状态管理'),
            SizedBox(height: 8),
            Text('• 通过 logic 属性访问 Controller'),
            SizedBox(height: 8),
            Text('• 可重写 buildAppBar、buildScaffold 等方法'),
          ],
        ),
      ),
    );
  }

  Widget _buildDataBinding() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('来自 Controller 的消息：',
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(logic.message,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetBuilderDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GetBuilder<BaseViewDemoLogic>(
              builder: (ctrl) => Text(
                '计数器: ${ctrl.counter}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: logic.incrementCounter,
                  icon: const Icon(Icons.add),
                  label: const Text('增加'),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: logic.resetCounter,
                  icon: const Icon(Icons.refresh),
                  label: const Text('重置'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverrideMethods() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('View 可重写方法：', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text('• buildContent() - 构建页面主体内容'),
            Text('• buildAppBar() - 构建 AppBar'),
            Text('• buildScaffold() - 自定义 Scaffold'),
            Text('• buildFloatingActionButton() - 悬浮按钮'),
            Text('• buildBottomNavigationBar() - 底部导航'),
            SizedBox(height: 12),
            Text('Controller 可重写方法：',
                style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text('• onLoadPage() - 页面加载逻辑'),
            Text('• onInit() - 初始化'),
            Text('• onReady() - 页面就绪'),
            Text('• onClose() - 页面关闭'),
          ],
        ),
      ),
    );
  }
}
