import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lanyu_chat/routes/router.dart';

import '../../../base/BaseView.dart';
import 'logic.dart';

class HomePage extends BaseView<HomeLogic> {
  HomePage({super.key});

  @override
  bool isScaffold() => true;


  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(AppRoutes.ExampleList);
        },
        child: const Text('跳转示例列表'),
      ),
    );
  }
  
}
