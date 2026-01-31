import 'package:hive_ce/hive.dart';

import '../model/adapters.dart';
import '../core/base_repository.dart';

/// 演示仓库
/// 用于 Hive 演示页面的键值对存储
class DemoRepository extends BaseRepository<String> {
  Box<String>? _box;
  bool _isReady = false;

  DemoRepository() : super(Boxes.demo.name);

  bool get isReady => _isReady;

  Future<void> init() async {
    if (_isReady) return;
    _box = await Boxes.demo.open();
    _isReady = true;
  }

  @override
  Box<String> get box {
    if (!_isReady || _box == null) {
      throw StateError('DemoRepository 未初始化，请先调用 init()');
    }
    return _box!;
  }

  List<MapEntry<String, String>> getAllEntries() {
    return box.keys
        .map((key) => MapEntry(key.toString(), box.get(key) ?? ''))
        .toList();
  }

  Future<void> addDemoData() async {
    await put('demo_string', 'Hello Hive!');
    await put('demo_number', '12345');
    await put('demo_bool', 'true');
    await put('demo_timestamp', DateTime.now().toString());
  }

  Future<void> close() async {
    if (_isReady && _box != null) {
      await _box!.close();
      _box = null;
      _isReady = false;
    }
  }
}
