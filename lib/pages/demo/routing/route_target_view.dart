import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 路由目标页面
/// 用于演示路由导航的目标页面，展示参数接收和返回结果
class RouteTargetPage extends StatelessWidget {
  const RouteTargetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final queryParams = Get.parameters;

    return Scaffold(
      appBar: AppBar(
        title: const Text('路由目标页'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('路由信息', [
              '当前路由: ${Get.currentRoute}',
              '上一个路由: ${Get.previousRoute}',
            ]),
            const SizedBox(height: 16),
            _buildInfoCard('Arguments 参数', _formatArgs(args)),
            const SizedBox(height: 16),
            _buildInfoCard('URL Query 参数', _formatQueryParams(queryParams)),
            const SizedBox(height: 24),
            _buildReturnSection(args),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (items.isEmpty)
              Text('无数据', style: TextStyle(color: Colors.grey[600]))
            else
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(item,
                        style: const TextStyle(fontFamily: 'monospace')),
                  )),
          ],
        ),
      ),
    );
  }

  List<String> _formatArgs(Map<String, dynamic>? args) {
    if (args == null || args.isEmpty) return [];
    return args.entries.map((e) => '${e.key}: ${e.value}').toList();
  }

  List<String> _formatQueryParams(Map<String, String?> params) {
    if (params.isEmpty) return [];
    return params.entries.map((e) => '${e.key}: ${e.value ?? "null"}').toList();
  }

  Widget _buildReturnSection(Map<String, dynamic>? args) {
    final waitResult = args?['waitResult'] == true;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('返回操作',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (waitResult) ...[
              const Text('此页面需要返回结果', style: TextStyle(color: Colors.orange)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          Get.back(result: {'status': 'success', 'data': 'OK'}),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text('返回成功',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(result: {'status': 'cancel'}),
                      child: const Text('返回取消'),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('返回上一页'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
