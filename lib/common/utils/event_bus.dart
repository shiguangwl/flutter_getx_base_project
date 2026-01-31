/// 事件订阅者回调签名
typedef EventCallback = void Function(Object? arg);

class EventBus {
  EventBus._internal();

  static final EventBus _singleton = EventBus._internal();

  factory EventBus() => _singleton;

  final _emap = <Object, List<EventCallback>?>{};

  /// 添加订阅者
  void on(Object eventName, EventCallback f) {
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  /// 移除订阅者
  void off(Object eventName, [EventCallback? f]) {
    final list = _emap[eventName];
    if (list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  /// 触发事件，事件触发后该事件所有订阅者会被调用
  void emit(Object eventName, [Object? arg]) {
    final list = _emap[eventName];
    if (list == null) return;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = list.length - 1; i >= 0; --i) {
      list[i](arg);
    }
  }

  /// 清除所有订阅
  void clear() {
    _emap.clear();
  }
}

/// 全局 EventBus 实例
final bus = EventBus();
