import 'dart:developer' as developer;
import 'dart:io';

import 'package:logger/logger.dart';

import 'filter/log_filter.dart';
import 'log_config.dart';
import 'log_level.dart';
import 'output/isolate_file_output.dart';
import 'output/silent_file_output.dart';

class Log {
  static Logger? _logger;
  static LogConfig? _config;
  static IsolateFileOutput? _fileOutput;
  static SilentFileOutput? _silentOutput;
  static bool _initialized = false;

  static Future<void> init(LogConfig config) async {
    _config = config;
    List<LogOutput> outputs = [ConsoleOutput()];

    if (config.canWriteToFile) {
      final fileOutput = IsolateFileOutput(config);
      await fileOutput.init();
      _fileOutput = fileOutput;
      _silentOutput = SilentFileOutput(fileOutput);
      outputs.add(fileOutput);
    }

    if (config.output != null) {
      outputs = [...outputs, ...config.output!];
    }

    _logger = Logger(
      filter: ComLogFilter(LevelAdapter.toLevel(config.logLevel)),
      printer: PrettyPrinter(),
      output: MultiOutput(outputs),
    );
    _initialized = true;
  }

  static void _ensureInitialized() {
    if (!_initialized || _config == null) {
      throw StateError('Log not initialized. Call Log.init() first.');
    }
  }

  static Future<Directory> getLogDir() async {
    _ensureInitialized();
    if (_config!.logDirectory == null) {
      throw StateError('Log directory not configured');
    }
    return _config!.logDirectory!;
  }

  static Future<List<String>> readLogsByDate({DateTime? date}) async {
    if (_config == null || !_config!.canWriteToFile) {
      return [];
    }

    date ??= DateTime.now();
    final dateStr =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final file = File('${_config!.logDirectory!.path}/log_$dateStr.log');
    if (await file.exists()) {
      return await file.readAsLines();
    }
    return [];
  }

  static void console(
    String message, {
    DateTime? time,
    int level = 500,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
  }) {
    final logLevel = _developerLevelToLoggerLevel(level);

    developer.log(
      message,
      time: time ?? DateTime.now(),
      level: level,
      name: name.isNotEmpty ? name : 'CONSOLE',
      error: error,
      stackTrace: stackTrace,
    );

    if (_config?.canWriteToFile == true && _silentOutput != null) {
      try {
        final outputEvent = OutputEvent(
          LogEvent(logLevel, message,
              error: error, stackTrace: stackTrace, time: time),
          [message],
        );
        _silentOutput!.output(outputEvent);
      } catch (e) {
        developer.log('日志写入失败: $e');
      }
    }
  }

  static Level _developerLevelToLoggerLevel(int developerLevel) {
    return switch (developerLevel) {
      >= 1000 => Level.error,
      >= 900 => Level.warning,
      >= 800 => Level.info,
      >= 500 => Level.debug,
      _ => Level.all,
    };
  }

  static void d(dynamic message) => _logger?.d(message);
  static void i(dynamic message) => _logger?.i(message);
  static void w(dynamic message) => _logger?.w(message);
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger?.e(message, error: error, stackTrace: stackTrace);

  /// 释放资源
  static Future<void> dispose() async {
    await _fileOutput?.destroy();
    _fileOutput = null;
    _silentOutput = null;
    _logger?.close();
    _logger = null;
    _initialized = false;
  }
}
