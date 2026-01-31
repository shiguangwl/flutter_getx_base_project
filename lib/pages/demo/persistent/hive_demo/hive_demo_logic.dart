import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../../persistent/repository/demo_repository.dart';

/// Hive 演示控制器
/// 使用 DemoRepository 封装，避免直接操作原始 Hive API
class HiveDemoLogic extends GetxController {
  final items = <MapEntry<String, String>>[].obs;
  final keyController = TextEditingController();
  final valueController = TextEditingController();
  final statusMessage = ''.obs;

  final DemoRepository _repo = DemoRepository();

  @override
  void onInit() {
    super.onInit();
    _initRepo();
  }

  Future<void> _initRepo() async {
    await _repo.init();
    _loadAllItems();
  }

  void _loadAllItems() {
    if (!_repo.isReady) return;
    items.value = _repo.getAllEntries();
  }

  void _showMessage(String title, String message) {
    statusMessage.value = '$title: $message';
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  /// 保存键值对
  Future<void> saveItem() async {
    final key = keyController.text.trim();
    final value = valueController.text.trim();
    if (key.isEmpty) {
      _showMessage('提示', '请输入 Key');
      return;
    }
    await _repo.put(key, value);
    keyController.clear();
    valueController.clear();
    _loadAllItems();
    _showMessage('成功', '已保存: $key = $value');
  }

  /// 读取指定 key
  void readItem(String key) {
    final value = _repo.get(key);
    _showMessage('读取结果', '$key = $value');
  }

  /// 删除指定 key
  Future<void> deleteItem(String key) async {
    await _repo.delete(key);
    _loadAllItems();
    _showMessage('成功', '已删除: $key');
  }

  /// 清空所有数据
  Future<void> clearAll() async {
    await _repo.clear();
    _loadAllItems();
    _showMessage('成功', '已清空所有数据');
  }

  /// 添加演示数据
  Future<void> addDemoData() async {
    await _repo.addDemoData();
    _loadAllItems();
    _showMessage('成功', '已添加演示数据');
  }

  @override
  void onClose() {
    keyController.dispose();
    valueController.dispose();
    super.onClose();
  }
}
