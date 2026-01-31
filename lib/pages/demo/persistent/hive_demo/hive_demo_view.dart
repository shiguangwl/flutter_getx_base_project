import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'hive_demo_logic.dart';

/// Hive 演示页面
/// 展示键值对存储、CRUD 操作
class HiveDemoPage extends GetView<HiveDemoLogic> {
  const HiveDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive 演示'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _confirmClearAll,
            tooltip: '清空所有',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildInputSection(),
          const Divider(height: 1),
          _buildActionButtons(),
          const Divider(height: 1),
          Expanded(child: _buildDataList()),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('添加/更新数据',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Key',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (v) => controller.keyController.text = v,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Value',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (v) => controller.valueController.text = v,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: controller.saveItem,
                child: const Text('保存'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: controller.addDemoData,
            icon: const Icon(Icons.add_box),
            label: const Text('添加演示数据'),
          ),
          const Spacer(),
          Obx(() => Text(
                '共 ${controller.items.length} 条数据',
                style: TextStyle(color: Colors.grey[600]),
              )),
        ],
      ),
    );
  }

  Widget _buildDataList() {
    return Obx(() {
      if (controller.items.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text('暂无数据', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 8),
              TextButton(
                onPressed: controller.addDemoData,
                child: const Text('点击添加演示数据'),
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: controller.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, index) {
          final item = controller.items[index];
          return Card(
            child: ListTile(
              title: Text(item.key,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(item.value,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility, size: 20),
                    onPressed: () => controller.readItem(item.key),
                    tooltip: '读取',
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, size: 20, color: Colors.red[400]),
                    onPressed: () => controller.deleteItem(item.key),
                    tooltip: '删除',
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void _confirmClearAll() {
    Get.dialog(
      AlertDialog(
        title: const Text('确认清空'),
        content: const Text('确定要清空所有数据吗？此操作不可撤销。'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.clearAll();
            },
            child: const Text('确定', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
