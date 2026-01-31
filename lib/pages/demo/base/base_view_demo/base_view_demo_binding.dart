import 'package:get/get.dart';
import 'base_view_demo_logic.dart';

class BaseViewDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BaseViewDemoLogic());
  }
}
