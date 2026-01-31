import 'dart:convert';

import 'package:flutter/material.dart';

/// Json Util.
class JsonUtil {
  /// Converts object [value] to a JSON string.
  static String? encodeObj(Object? value) {
    return value == null ? null : json.encode(value);
  }

  /// Converts JSON string [source] to object.
  static T? getObj<T>(String? source, T Function(Map<String, dynamic> v) f) {
    if (source == null || source.isEmpty) return null;
    try {
      final map = json.decode(source) as Map<String, dynamic>;
      return f(map);
    } catch (e) {
      debugPrint('JsonUtil convert error, Exception：${e.toString()}');
    }
    return null;
  }

  /// Converts JSON string or JSON map [source] to object.
  static T? getObject<T>(Object? source, T Function(Map<String, dynamic> v) f) {
    if (source == null || source.toString().isEmpty) return null;
    try {
      Map<String, dynamic> map;
      if (source is String) {
        map = json.decode(source) as Map<String, dynamic>;
      } else if (source is Map) {
        map = Map<String, dynamic>.from(source);
      } else {
        return null;
      }
      return f(map);
    } catch (e) {
      debugPrint('JsonUtil convert error, Exception：${e.toString()}');
    }
    return null;
  }

  /// Converts JSON string list [source] to object list.
  static List<T>? getObjList<T>(
      String? source, T Function(Map<String, dynamic> v) f) {
    if (source == null || source.isEmpty) return null;
    try {
      final list = json.decode(source) as List;
      return list.map((value) {
        if (value is String) {
          value = json.decode(value);
        }
        return f(Map<String, dynamic>.from(value as Map));
      }).toList();
    } catch (e) {
      debugPrint('JsonUtil convert error, Exception：${e.toString()}');
    }
    return null;
  }

  /// Converts JSON string or JSON map list [source] to object list.
  static List<T>? getObjectList<T>(
      Object? source, T Function(Map<String, dynamic> v) f) {
    if (source == null || source.toString().isEmpty) return null;
    try {
      List<Object?> list;
      if (source is String) {
        list = json.decode(source) as List;
      } else if (source is List) {
        list = source;
      } else {
        return null;
      }
      return list.map((value) {
        if (value is String) {
          value = json.decode(value);
        }
        return f(Map<String, dynamic>.from(value as Map));
      }).toList();
    } catch (e) {
      debugPrint('JsonUtil convert error, Exception：${e.toString()}');
    }
    return null;
  }

  /// get List from JSON string or List
  static List<T>? getList<T>(Object? source) {
    if (source == null) return null;
    try {
      List<Object?> list;
      if (source is String) {
        list = json.decode(source) as List;
      } else if (source is List) {
        list = source;
      } else {
        return null;
      }
      return list.whereType<T>().toList();
    } catch (e) {
      debugPrint('JsonUtil getList error: $e');
    }
    return null;
  }
}
