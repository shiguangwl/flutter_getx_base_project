import 'package:flutter/material.dart';

import '../../../base/BaseView.dart';
import 'logic.dart';

class HomePage extends BaseView<HomeLogic> {
  HomePage({super.key});

  @override
  bool isScaffold() => true;


  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: Text("Home"),
    );
  }
  
}
