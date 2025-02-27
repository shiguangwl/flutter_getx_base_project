import 'package:flutter/material.dart';
import '../../base/refreshable_view.dart';
import 'example_list_controller.dart';

class ExampleListPage extends RefreshableView<ExampleListController> {
  const ExampleListPage({super.key});

  @override
  bool isScaffold() => true;

  @override
  Widget buildListItem(BuildContext context, int index) {
    return ListTile(
      title: Text(logic.items[index]),
    );
  }

  @override
  int getItemCount() {
    return logic.items.length;
  }

  @override
  Scaffold buildScaffold(Widget contentView) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('示例列表'),
      ),
      body: contentView,
    );
  }
} 