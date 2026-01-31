import 'package:get/get.dart';
import 'refreshable_demo_logic.dart';

class RefreshableDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RefreshableDemoLogic());
  }
}
