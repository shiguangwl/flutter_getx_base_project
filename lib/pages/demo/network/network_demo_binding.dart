import 'package:get/get.dart';
import 'network_demo_logic.dart';

class NetworkDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkDemoLogic());
  }
}
