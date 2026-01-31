import 'package:get/get.dart';
import 'routing_demo_logic.dart';

class RoutingDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RoutingDemoLogic());
  }
}
