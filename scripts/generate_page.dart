// ignore_for_file: avoid_print
import 'dart:io';

/// 页面代码生成器
/// 用法: dart run scripts/generate_page.dart &lt;page_name&gt; [module_name]
/// 示例: dart run scripts/generate_page.dart login auth

void main(List<String> args) {
  if (args.isEmpty) {
    print('用法: dart run scripts/generate_page.dart <page_name> [module_name]');
    print('示例: dart run scripts/generate_page.dart login auth');
    exit(1);
  }

  final pageName = args[0];
  final moduleName = args.length > 1 ? args[1] : null;

  final generator = PageGenerator(pageName, moduleName);
  generator.generate();
}

class PageGenerator {
  final String pageName;
  final String? moduleName;

  PageGenerator(this.pageName, this.moduleName);

  String get _pascalCase => _toPascalCase(pageName);
  String get _snakeCase => _toSnakeCase(pageName);

  String get _basePath {
    if (moduleName != null) {
      return 'lib/pages/$moduleName/$_snakeCase';
    }
    return 'lib/pages/$_snakeCase';
  }

  void generate() {
    final dir = Directory(_basePath);
    if (dir.existsSync()) {
      print('错误: 目录已存在 $_basePath');
      exit(1);
    }

    dir.createSync(recursive: true);

    _createController();
    _createView();
    _createBindings();
    _updateRoutes();

    print('✅ 页面创建成功: $_basePath');
    print('   - ${_snakeCase}_controller.dart');
    print('   - ${_snakeCase}_view.dart');
    print('   - ${_snakeCase}_bindings.dart');
    print('\n📝 请手动将路由添加到 lib/routes/router.dart');
  }

  void _createController() {
    final content = '''import 'package:get/get.dart';

import '../../common/base/controller/base_controller.dart';

class ${_pascalCase}Controller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
''';
    File('$_basePath/${_snakeCase}_controller.dart').writeAsStringSync(content);
  }

  void _createView() {
    final content = '''import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '${_snakeCase}_controller.dart';

class ${_pascalCase}View extends GetView<${_pascalCase}Controller> {
  const ${_pascalCase}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$_pascalCase')),
      body: const Center(child: Text('$_pascalCase Page')),
    );
  }
}
''';
    File('$_basePath/${_snakeCase}_view.dart').writeAsStringSync(content);
  }

  void _createBindings() {
    final content = '''import 'package:get/get.dart';

import '${_snakeCase}_controller.dart';

class ${_pascalCase}Bindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${_pascalCase}Controller>(() => ${_pascalCase}Controller());
  }
}
''';
    File('$_basePath/${_snakeCase}_bindings.dart').writeAsStringSync(content);
  }

  void _updateRoutes() {
    final routeSnippet = '''
// TODO: 添加到 AppRoutes
// static const String $_pascalCase = '/$_snakeCase';
// GetPage(
//   name: $_pascalCase,
//   page: () => const ${_pascalCase}View(),
//   binding: ${_pascalCase}Bindings(),
// ),
''';
    print(routeSnippet);
  }

  String _toPascalCase(String input) {
    return input.split('_').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join();
  }

  String _toSnakeCase(String input) {
    return input
        .replaceAllMapped(RegExp(r'[A-Z]'), (m) => '_${m.group(0)}')
        .toLowerCase()
        .replaceFirst(RegExp(r'^_'), '');
  }
}
