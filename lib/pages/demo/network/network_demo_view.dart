import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'network_demo_logic.dart';

/// 网络层演示页面
/// 展示 GET/POST/PUT/DELETE、缓存、取消请求等功能
class NetworkDemoPage extends GetView<NetworkDemoLogic> {
  const NetworkDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络请求演示'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: controller.clearLogs,
            tooltip: '清空日志',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildRequestButtons(),
          const Divider(height: 1),
          Expanded(child: _buildResultArea()),
        ],
      ),
    );
  }

  Widget _buildRequestButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础请求',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildButton('GET', Colors.green, controller.demoGet),
              _buildButton('POST', Colors.blue, controller.demoPost),
              _buildButton('PUT', Colors.orange, controller.demoPut),
              _buildButton('DELETE', Colors.red, controller.demoDelete),
            ],
          ),
          const SizedBox(height: 16),
          const Text('高级功能',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildButton('缓存演示', Colors.purple, controller.demoCache),
              _buildButton('取消请求', Colors.teal, controller.demoCancelRequest),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return Obx(() => ElevatedButton(
          onPressed: controller.isLoading.value ? null : onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(label, style: const TextStyle(color: Colors.white)),
        ));
  }

  Widget _buildResultArea() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Expanded(flex: 2, child: _buildResponsePanel()),
          const Divider(height: 1),
          Expanded(flex: 1, child: _buildLogPanel()),
        ],
      ),
    );
  }

  Widget _buildResponsePanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('响应结果', style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Obx(() => controller.isLoading.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Obx(() => SingleChildScrollView(
                    child: Text(
                      controller.responseText.value.isEmpty
                          ? '点击上方按钮发起请求'
                          : controller.responseText.value,
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('请求日志', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.requestLogs.length,
                  itemBuilder: (_, index) {
                    final log = controller.requestLogs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(log,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[700])),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
