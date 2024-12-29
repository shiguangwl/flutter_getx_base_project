import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../R.dart';
import '../../base/BaseView.dart';
import 'logic.dart';

class LaunchPage extends BaseView {
  LaunchPage({super.key});

  final logic = Get.put(LaunchLogic());

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LaunchLogic>(
        init: logic,
        builder: (logic) {
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
        },
      ),
    );
  }
}
