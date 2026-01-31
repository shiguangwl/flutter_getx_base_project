import 'dart:async';

import 'package:flutter/material.dart';

/// 函数节流/防抖管理器
class _FunctionThrottleManager {
  static final Map<int, bool> _throttleFlags = {};
  static final Map<int, Timer> _debounceTimers = {};

  static void throttle(Function target, int timeout) {
    final key = target.hashCode;
    if (_throttleFlags[key] ?? true) {
      _throttleFlags[key] = false;
      Timer(Duration(milliseconds: timeout), () => _throttleFlags.remove(key));
      target.call();
    }
  }

  static void debounce(Function target, int timeout) {
    final key = target.hashCode;
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(Duration(milliseconds: timeout), () {
      _debounceTimers.remove(key);
      target.call();
    });
  }

  static void throttleValue<T>(ValueChanged<T> target, T value, int timeout) {
    final key = target.hashCode;
    if (_throttleFlags[key] ?? true) {
      _throttleFlags[key] = false;
      Timer(Duration(milliseconds: timeout), () => _throttleFlags.remove(key));
      target.call(value);
    }
  }

  static void debounceValue<T>(ValueChanged<T> target, T value, int timeout) {
    final key = target.hashCode;
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(Duration(milliseconds: timeout), () {
      _debounceTimers.remove(key);
      target.call(value);
    });
  }

  /// 清理指定函数的节流/防抖状态
  // ignore: unused_element
  static void clear(Function target) {
    final key = target.hashCode;
    _throttleFlags.remove(key);
    _debounceTimers.remove(key)?.cancel();
  }

  /// 清理所有状态
  // ignore: unused_element
  static void clearAll() {
    _throttleFlags.clear();
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
  }
}

extension FunctionExt on Function {
  VoidCallback throttle({int timeout = 500}) {
    return () => _FunctionThrottleManager.throttle(this, timeout);
  }

  VoidCallback debounce({int timeout = 500}) {
    return () => _FunctionThrottleManager.debounce(this, timeout);
  }
}

extension FunctionValueExt<T> on ValueChanged<T> {
  ValueChanged<T> throttle({int timeout = 500}) {
    return (value) =>
        _FunctionThrottleManager.throttleValue(this, value, timeout);
  }

  ValueChanged<T> debounce({int timeout = 500}) {
    return (value) =>
        _FunctionThrottleManager.debounceValue(this, value, timeout);
  }
}
