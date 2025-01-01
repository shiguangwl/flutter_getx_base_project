import 'package:flutter/material.dart';
import '../../R.dart';
import '../../base/BaseView.dart';
import 'logic.dart';

class LaunchPage extends BaseView<LaunchLogic> {
  LaunchPage({super.key});

  @override
  bool isScaffold() => true;


  @override
  Widget buildContent(BuildContext context) {
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 250, height: 250, child: Image.asset(R.Logo)),
        const SizedBox(
          height: 10,
        ),
        Text(
          "加载中...",
          style: const TextStyle(fontSize: 20),
        ),
      ],
    ),
  );
}
  
}
