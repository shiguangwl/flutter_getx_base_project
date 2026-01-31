import 'package:flutter/material.dart';
import '../../common/base/config/view_config.dart';
import '../../common/base/view/base_view.dart';
import 'logic.dart';

class LaunchPage extends BaseView<LaunchLogic> {
  const LaunchPage({super.key});

  @override
  ViewConfig get viewConfig => ViewConfig(
        useScaffold: true,
      );

  @override
  Widget buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "加载中...",
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
