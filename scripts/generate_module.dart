// ignore_for_file: avoid_print
import 'dart:io';

/// 模块代码生成器
/// 用法: dart run scripts/generate_module.dart <module_name>
/// 示例: dart run scripts/generate_module.dart user

void main(List<String> args) {
  if (args.isEmpty) {
    print('用法: dart run scripts/generate_module.dart <module_name>');
    print('示例: dart run scripts/generate_module.dart user');
    exit(1);
  }

  final moduleName = args[0];
  final generator = ModuleGenerator(moduleName);
  generator.generate();
}

class ModuleGenerator {
  final String moduleName;

  ModuleGenerator(this.moduleName);

  String get _pascalCase => _toPascalCase(moduleName);
  String get _snakeCase => _toSnakeCase(moduleName);
  String get _basePath => 'lib/modules/$_snakeCase';

  void generate() {
    final dir = Directory(_basePath);
    if (dir.existsSync()) {
      print('错误: 模块已存在 $_basePath');
      exit(1);
    }

    dir.createSync(recursive: true);
    Directory('$_basePath/models').createSync();
    Directory('$_basePath/services').createSync();
    Directory('$_basePath/pages').createSync();

    _createModel();
    _createService();
    _createIndex();

    print('✅ 模块创建成功: $_basePath');
    print('   - models/${_snakeCase}_model.dart');
    print('   - services/${_snakeCase}_service.dart');
    print('   - index.dart');
  }

  void _createModel() {
    final content = '''/// ${_pascalCase}模型
class ${_pascalCase}Model {
  final String id;
  final String name;
  final DateTime createdAt;

  const ${_pascalCase}Model({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory ${_pascalCase}Model.fromJson(Map<String, dynamic> json) {
    return ${_pascalCase}Model(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'created_at': createdAt.toIso8601String(),
  };

  ${_pascalCase}Model copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return ${_pascalCase}Model(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
''';
    File('$_basePath/models/${_snakeCase}_model.dart')
        .writeAsStringSync(content);
  }

  void _createService() {
    final content = '''import 'package:get/get.dart';

import '../models/${_snakeCase}_model.dart';

/// ${_pascalCase}服务
class ${_pascalCase}Service extends GetxService {
  static ${_pascalCase}Service get to => Get.find<${_pascalCase}Service>();

  final RxList<${_pascalCase}Model> items = <${_pascalCase}Model>[].obs;
  final Rx<${_pascalCase}Model?> current = Rx<${_pascalCase}Model?>(null);

  Future<List<${_pascalCase}Model>> fetchList() async {
    // TODO: 实现API调用
    return items;
  }

  Future<${_pascalCase}Model?> fetchById(String id) async {
    // TODO: 实现API调用
    return null;
  }

  Future<void> create(${_pascalCase}Model model) async {
    // TODO: 实现API调用
    items.add(model);
  }

  Future<void> update(${_pascalCase}Model model) async {
    // TODO: 实现API调用
    final index = items.indexWhere((e) => e.id == model.id);
    if (index != -1) {
      items[index] = model;
    }
  }

  Future<void> delete(String id) async {
    // TODO: 实现API调用
    items.removeWhere((e) => e.id == id);
  }
}
''';
    File('$_basePath/services/${_snakeCase}_service.dart')
        .writeAsStringSync(content);
  }

  void _createIndex() {
    final content = '''export 'models/${_snakeCase}_model.dart';
export 'services/${_snakeCase}_service.dart';
''';
    File('$_basePath/index.dart').writeAsStringSync(content);
  }

  String _toPascalCase(String input) {
    return input.split('_').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join();
  }

  String _toSnakeCase(String input) {
    return input
        .replaceAllMapped(RegExp(r'[A-Z]'), (m) => '_\${m.group(0)}')
        .toLowerCase()
        .replaceFirst(RegExp(r'^_'), '');
  }
}
