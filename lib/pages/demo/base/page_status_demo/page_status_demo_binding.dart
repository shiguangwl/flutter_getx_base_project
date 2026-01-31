import 'package:get/get.dart';
import 'page_status_demo_logic.dart';

class PageStatusDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PageStatusDemoLogic());
  }
}
