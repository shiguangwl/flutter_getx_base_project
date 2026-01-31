import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'common/log/log_config.dart';
import 'common/log/log_level.dart';
import 'common/log/logger.dart';
import 'service/ainit.dart';

/// 全局静态数据
class Global {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initLog();
    await _setSystemUi();
    await Ainit.init();
  }

  static Future _initLog() async {
    Directory dir = await getApplicationDocumentsDirectory();
    await Log.init(
      LogConfig(
        retentionDays: 3, // 日志保留天数
        enableFileLog: true, // 启用文件日志
        logLevel: LogLevel.all, // 日志过滤级别
        recordLevel: LogLevel.info, // 日志记录级别
        output: const [], // 自定义输出
        logDirectory: Directory('${dir.path}/logs'), // 日志目录
      ),
    );
  }

  static Future _setSystemUi() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
