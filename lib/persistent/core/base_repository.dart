import 'package:hive_ce/hive.dart';

/// 泛型 Repository 基类
/// 提供通用 CRUD 操作，减少模板代码
abstract class BaseRepository<T> {
  final String boxName;
  Box<T>? _cachedBox;

  BaseRepository(this.boxName);

  Box<T> get box => _cachedBox ??= Hive.box<T>(boxName);

  T? get(String key) => box.get(key);

  Future<void> put(String key, T value) => box.put(key, value);

  Future<void> delete(String key) => box.delete(key);

  bool containsKey(String key) => box.containsKey(key);

  List<T> getAll() => box.values.toList();

  Future<void> clear() => box.clear();
}
