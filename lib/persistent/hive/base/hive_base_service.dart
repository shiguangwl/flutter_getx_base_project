import 'package:hive/hive.dart';
import 'dart:async';

/// Hive数据库服务基类
abstract class HiveBaseService<T> {
  /// 盒子名称
  final String boxName;
  
  /// 盒子对象
  Box<T>? _box;

  HiveBaseService(this.boxName);

  /// 初始化盒子
  Future<void> init() async {
    if (_box != null && _box!.isOpen) return;
    
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<T>(boxName);
    } else {
      _box = Hive.box<T>(boxName);
    }
  }

  /// 获取盒子实例
  Box<T> get box {
    if (_box == null || !_box!.isOpen) {
      throw StateError('Box not initialized or closed. Call init() first.');
    }
    return _box!;
  }

  /// 清空所有数据
  Future<void> clear() async {
    await box.clear();
  }

  /// 添加数据
  Future<int> add(T value) async {
    return await box.add(value);
  }

  /// 批量添加数据
  Future<void> addAll(List<T> values) async {
    await box.addAll(values);
  }

  /// 根据键获取值
  T? get(dynamic key) {
    return box.get(key);
  }

  /// 获取所有值
  List<T> getAll() {
    return box.values.toList();
  }

  /// 根据键更新值
  Future<void> put(dynamic key, T value) async {
    await box.put(key, value);
  }

  /// 批量更新值
  Future<void> putAll(Map<dynamic, T> entries) async {
    await box.putAll(entries);
  }

  /// 删除指定键的值
  Future<void> delete(dynamic key) async {
    await box.delete(key);
  }

  /// 批量删除
  Future<void> deleteAll(List<dynamic> keys) async {
    await box.deleteAll(keys);
  }

  /// 判断是否包含某个键
  bool containsKey(dynamic key) {
    return box.containsKey(key);
  }

  /// 获取所有键
  List<dynamic> getAllKeys() {
    return box.keys.toList();
  }

  /// 获取数据长度
  int get length => box.length;

  /// 判断是否为空
  bool get isEmpty => box.isEmpty;

  /// 判断是否不为空
  bool get isNotEmpty => box.isNotEmpty;

  /// 监听数据变化
  StreamSubscription<BoxEvent> watch({
    dynamic key,
    void Function(BoxEvent event)? onData,
  }) {
    return box.watch(key: key).listen(onData);
  }

  /// 根据条件查询数据
  List<T> where(bool Function(T value) test) {
    return box.values.where(test).toList();
  }

  /// 根据条件查询单个数据
  T? firstWhere(
    bool Function(T value) test, {
    T Function()? orElse,
  }) {
    try {
      return box.values.firstWhere(test);
    } catch (e) {
      if (orElse != null) {
        return orElse();
      }
      return null;
    }
  }

  Future<void> close() async {
    await _box?.close();
    _box = null;
  }
}
