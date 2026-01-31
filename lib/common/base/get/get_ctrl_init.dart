import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Get控制器初始化组件
class GetCtrlInit<T extends GetxController> extends StatefulWidget {
  final T controller;
  final String? tag;
  final Widget child;

  const GetCtrlInit({
    super.key,
    required this.controller,
    required this.child,
    this.tag,
  });

  @override
  State<GetCtrlInit<T>> createState() => _GetCtrlInitState<T>();
}

class _GetCtrlInitState<T extends GetxController>
    extends State<GetCtrlInit<T>> {
  @override
  void initState() {
    super.initState();
    Get.put(widget.controller, tag: widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
