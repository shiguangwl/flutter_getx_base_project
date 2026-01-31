import 'package:get/get.dart';
import 'hive_demo_logic.dart';

class HiveDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HiveDemoLogic());
  }
}
